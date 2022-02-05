import 'package:example/package/undo_redo_stack.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  static const route = '/example_page';
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final stack = UndoRedoStack<Widget>();
  final whiteText = const TextStyle(color: Colors.white);
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Undo Redo List'),
          actions: [
            IconButton(
                onPressed: stack.canUndo ? _onUndoPressed : null,
                icon: const Icon(Icons.arrow_back)),
            IconButton(
                onPressed: stack.canRedo ? _onRedoPressed : null,
                icon: const Icon(Icons.arrow_forward)),
            IconButton(
                onPressed: _onClearPressed, icon: const Icon(Icons.delete)),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(children: stack.list),
            ),
            MaterialButton(
              onPressed: _addItem,
              child: Text('Add', style: whiteText),
              color: Colors.green,
            ),
            MaterialButton(
                onPressed: _deleteItem,
                child: Text('Delete Forever', style: whiteText),
                color: Colors.red)
          ],
        ));
  }

  // UndoRedoStack Updates
  void _onUndoPressed() => setState(() => stack.undo());
  void _onRedoPressed() => setState(() => stack.redo());
  void _onClearPressed() => setState(() {
        stack.clear();
        itemCount = 0;
      });

  // Add Item to List
  void _addItem() {
    final item = Text('New Item #${++itemCount}');
    setState(() => stack.push(item));
  }

  // Delete Item to List (not redo-able)
  void _deleteItem() => setState(() => stack.pop());
}
