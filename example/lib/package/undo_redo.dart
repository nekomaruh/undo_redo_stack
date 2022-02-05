/*
import 'dart:collection';

enum StackState { none, add, delete, undoDelete, move, undo }

class StackModel<T> {
  late StackState stackState = StackState.none;
  late T data;
  late int index;
  late int prevIndex;
  late int nextIndex;
  StackModel(
      {required this.data,
      required this.stackState,
      required this.index,
      required this.prevIndex,
      required this.nextIndex});
}

class UndoStack<T> {
  final _mainStack = Queue<StackModel<T>>();
  final _undoStack = Queue<StackModel<T>>();
  int index = 0;

  void push(T element) {
    final stackModel = StackModel(
        data: element,
        stackState: StackState.add,
        index: index,
        prevIndex: index - 1,
        nextIndex: index + 1);
    index++;
    _mainStack.addLast(stackModel);
  }

  T? pop({bool forever = false}) {
    if (_mainStack.isNotEmpty) {
      StackModel<T> popElement = _mainStack.last;
      _mainStack.removeLast();
      popElement.stackState = StackState.delete;
      if (forever == false) {
        _undoStack.add(popElement);
      }
      return popElement.data;
    }
    return null;
  }

  void _stackToUndo() {
    if (_mainStack.isNotEmpty) {
      StackModel<T> mainElement = _mainStack.last;
      var state = mainElement.stackState;
      if (state == StackState.add) {
        state = StackState.undo;
      } else if (state == StackState.delete) {
        state = StackState.undoDelete;
      }
      _mainStack.removeLast();
      _undoStack.add(mainElement);
    }
  }

  void undo() {
    if (_undoStack.isNotEmpty) {
      StackModel<T> undoElement = _undoStack.last;
      var state = undoElement.stackState;
      if (state == StackState.delete &&
          _mainStack.last.index < undoElement.index) {
        print('undo(delete) -> stack');
        _undoStack.removeLast();
        undoElement.stackState = StackState.undoDelete;
        _mainStack.addLast(undoElement);
      } else {
        print('stack -> undo d');
        _stackToUndo();
      }
    } else {
      print('stack -> undo');
      _stackToUndo();
    }
    //print(_getUndoStates());
  }

  /*
  void redo() {
    if (_mainStack.isNotEmpty) {
      StackModel<T> undoElement = _mainStack.last;
      _mainStack.removeLast();
      _undoStack.add(undoElement);
    }
  }
  */

  void clear() {
    _undoStack.clear();
    _mainStack.clear();
    index = 0;
  }

  void undoAll() {
    if (_undoStack.isNotEmpty) {
      for (int i = 0; i <= _undoStack.length; i++) {
        undo();
      }
    }
  }

  /*
  void redoAll() {
    if (_mainStack.isNotEmpty) {
      for (int i = 0; i <= _mainStack.length; i++) {
        redo();
      }
    }
  }
  */

  _getListData(Queue<StackModel<T>> stack) {
    List<T> data = [];
    for (final element in stack) {
      data.add(element.data);
    }
    return data;
  }

  _getUndoStates() {
    List<StackState> data = [];
    for (final element in _undoStack) {
      data.add(element.stackState);
    }
    return data;
  }

  get list => _getListData(_mainStack);

  get undoList => _getListData(_undoStack);

  get listModel => _mainStack.toList();

  get canUndo => _mainStack.isNotEmpty;
}

*/