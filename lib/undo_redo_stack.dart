library undo_redo_stack;

import 'dart:collection';

class UndoRedoStack<T> {
  final _mainStack = Queue<T>();
  final _undoStack = Queue<T>();

  get canUndo => _mainStack.isNotEmpty;
  get canRedo => _undoStack.isNotEmpty;

  void push(T element) {
    _mainStack.addLast(element);
  }

  void pushList(List<T> list) {
    for (var element in list) {
      _mainStack.addLast(element);
    }
  }

  T? pop() {
    if (_mainStack.isNotEmpty) {
      T popElement = _mainStack.last;
      _mainStack.removeLast();
      return popElement;
    }
    return null;
  }

  void undo() {
    if (_mainStack.isNotEmpty) {
      T undoElement = _mainStack.last;
      _mainStack.removeLast();
      _undoStack.add(undoElement);
    }
  }

  void redo() {
    if (_undoStack.isNotEmpty) {
      T redoElement = _undoStack.last;
      _undoStack.removeLast();
      _mainStack.addLast(redoElement);
    }
  }

  get list => _mainStack.toList();

  get undoList => _undoStack.toList();

  void clear() {
    _undoStack.clear();
    _mainStack.clear();
  }

  void undoAll() {
    for (int i = 0; i <= _undoStack.length; i++) {
      undo();
    }
  }

  void redoAll() {
    for (int i = 0; i <= _mainStack.length; i++) {
      redo();
    }
  }
}
