import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      home: ToDoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}


/* here */
class ToDoList extends StatefulWidget {
  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  final List<ToDoItem> _items = [];

  void _addToDoItem(String title, String description) {
    setState(() {
      _items.add(ToDoItem(title: title, description: description));
    });
  }

  void _deleteToDoItem(ToDoItem item) {
    setState(() {
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            AddToDoItemForm(_addToDoItem),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ToDoItemTile(
                    item,
                    (newValue) {
                      setState(() {
                        item.isCompleted = !item.isCompleted;
                      });
                    },
                    () => _deleteToDoItem(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ToDoItemTile extends StatelessWidget {
  final ToDoItem item;
  final void Function(bool?) onChanged;
  final void Function() onDelete;

  const ToDoItemTile(this.item, this.onChanged, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.title,
        style: TextStyle(
          decoration: item.isCompleted ? TextDecoration.lineThrough : null,),
),
subtitle: Text(item.description),
trailing: Checkbox(
value: item.isCompleted,
onChanged: onChanged,
),
onLongPress: onDelete,
);
}
}
          
          
          
          
          
class AddToDoItemForm extends StatefulWidget {
  final void Function(String, String) onSubmit;

  const AddToDoItemForm(this.onSubmit);

  @override
  AddToDoItemFormState createState() => AddToDoItemFormState();
}

class AddToDoItemFormState extends State<AddToDoItemForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              if (widget.onSubmit != null && _titleController.text.isNotEmpty) {
                widget.onSubmit(_titleController.text, _descriptionController.text);
                _titleController.clear();
                _descriptionController.clear();
              }
            },
            child: Text('Add'),
          ),
        ),
      ],
    );
  }
}


class ToDoItem {
final String title;
final String description;
bool isCompleted;
  
 ToDoItem({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}
