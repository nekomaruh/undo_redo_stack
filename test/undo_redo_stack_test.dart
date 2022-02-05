import 'package:flutter_test/flutter_test.dart';

import 'package:undo_redo_stack/undo_redo_stack.dart';

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
