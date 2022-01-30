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
stack.pop() // Deletes data from stack and return? the value
stack.pop(forever: true) // Same as above, but this is not redo-able
stack.list // Returns list of values in stack
stack.undoList // Returns list of possible undo values
```

## Getting started

Import the package:

```dart
import 'package:undo_redo_stack/undo_redo_stack.dart';
```

## Usage

Flutter Example:

```dart
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Undo Redo List'),
          actions: [
            IconButton(
                onPressed: _onUndoPressed, icon: const Icon(Icons.arrow_back)),
            IconButton(
                onPressed: _onRedoPressed,
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
                child: Text('Delete', style: whiteText),
                color: Colors.red)
          ],
        ));
  }

  // UndoRedoStack Updates
  void _onUndoPressed() => setState(() => stack.undo());
  void _onRedoPressed() => setState(() => stack.redo());
  void _onClearPressed() => setState(() => stack.clear());

  // Add Item to List
  void _addItem() {
    final item = Text('New Item #${stack.list.length + 1}');
    setState(() => stack.push(item));
  }

  // Delete Item to List (not redo-able)
  void _deleteItem() => setState(() => stack.pop(forever: true));
}
```

Dart Example:

```dart
void main() {
  test('Undo Redo Stack Task Executed', () {
    final stack = UndoRedoStack<int>()
      ..push(3)
      ..push(2)
      ..push(10)
      ..push(9)
      ..push(5)
      ..push(7)
      ..push(6);

    print('Stack: ${stack.list}');

    stack
      ..pop()
      ..pop()
      ..pop();

    print('Deleted values: ${stack.undoList}');
    print('Stack: ${stack.list}');

    stack
      ..undo()
      ..undo()
      ..undo();

    print('Stack with 3 undos: ${stack.list}');

    stack
      ..redo()
      ..redo();

    print('Stack with 2 redos: ${stack.list}');

    int? value = stack.pop(forever: true);

    print('Value deleted forever: $value');
    print('Stack: ${stack.list}');

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
Deleted values: [6, 7, 5]
Stack: [3, 2, 10, 9]
Stack with 3 undos: [3, 2, 10, 9, 5, 7, 6]
Stack with 2 redos: [3, 2, 10, 9, 5]
Value deleted forever: 5
Stack: [3, 2, 10, 9]
Stack with full undo: [3, 2, 10, 9, 7, 6]
Stack with full redo: [3, 2]
Stack deleted forever: []
✓ Undo Redo Stack Task Executed
```

## Additional information

A very basic package made to avoid Undo-Redo boilerplate code. Everything made 
simple, commits and pull requests are welcomed.