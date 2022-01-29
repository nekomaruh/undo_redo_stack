library undo_redo_stack;

import 'dart:collection';

class UndoRedoStack<T> {
  final _undoStack = Queue<T>();
  final _redoStack = Queue<T>();

  void push(T element) {
    _undoStack.addLast(element);
  }

  T? pop({bool forever = false}) {
    if (_undoStack.isNotEmpty) {
      T popElement = _undoStack.last;
      _undoStack.removeLast();
      if (forever == false) _redoStack.add(popElement);
      return popElement;
    }
    return null;
  }

  void undo() {
    if (_redoStack.isNotEmpty) {
      T redoElement = _redoStack.last;
      _redoStack.removeLast();
      _undoStack.addLast(redoElement);
    }
  }

  void redo() {
    if (_undoStack.isNotEmpty) {
      T undoElement = _undoStack.last;
      _undoStack.removeLast();
      _redoStack.add(undoElement);
    }
  }

  get list => _undoStack.toList();

  get undoList => _redoStack.toList();

  void clear() {
    _redoStack.clear();
    _undoStack.clear();
  }

  void undoAll() {
    if (_redoStack.isNotEmpty) {
      for (int i = 0; i <= _redoStack.length; i++) {
        undo();
      }
    }
  }

  void redoAll() {
    if (_undoStack.isNotEmpty) {
      for (int i = 0; i <= _undoStack.length; i++) {
        redo();
      }
    }
  }
}
