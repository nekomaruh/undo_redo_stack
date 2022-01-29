import 'package:flutter_test/flutter_test.dart';

import 'package:undo_redo_stack/undo_redo_stack.dart';

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
