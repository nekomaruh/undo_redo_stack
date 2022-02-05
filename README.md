<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Undo Redo Stack for Widgets and any data types.

## Features

Suported data types: dynamic (by default), int, bool, double, String, Widget, etc.

Dart & Flutter:

```dart
final stack = UndoRedoStack<dynamic>(); // Instance

stack.undo() // Undo Changes
stack.redo() // Redo Changes
stack.clear() // Deletes all data from stack
stack.push(dynamic) // Add data to stack
stack.pushList(List<dynamic>) // Add list of data to stack
stack.pop() // Delete data from stack and return? the value
stack.list // Return list of values in stack
stack.undoList // Return list of possible redo values
```

## Getting started

Import the package:

```dart
import 'package:undo_redo_stack/undo_redo_stack.dart';
```

## Usage

Flutter Example:

```dart
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
```

Dart Example:

```dart
void main() {
  test('Undo Redo Stack Task Executed', () {
    final List<int> list = [3, 2, 10, 9, 5, 7, 6];
    final stack = UndoRedoStack<int>()..pushList(list);

    print('Stack: ${stack.list}');

    stack
      ..pop()
      ..pop()
      ..pop();

    print('Stack with 3 pops: ${stack.list}');

    stack
      ..undo()
      ..undo()
      ..undo();

    print('Stack with 3 undos: ${stack.list}');

    stack
      ..redo()
      ..redo();

    print('Stack with 2 redos: ${stack.list}');

    stack.undoAll();

    print('Stack with full undo: ${stack.list}');

    stack.redoAll();

    print('Stack with full redo: ${stack.list}');

    stack.clear();

    print('Stack deleted forever: ${stack.list}');
  });
}
```

Dart Example Result:
```dart
Stack: [3, 2, 10, 9, 5, 7, 6]
Stack with 3 pops: [3, 2, 10, 9]
Stack with 3 undos: [3]
Stack with 2 redos: [3, 2, 10]
Stack with full undo: []
Stack with full redo: [3, 2, 10, 9]
Stack deleted forever: []
✓ Undo Redo Stack Task Executed
```

## Additional information

A very basic package made to avoid Undo-Redo boilerplate code. Everything made 
simple, commits and pull requests are welcomed.