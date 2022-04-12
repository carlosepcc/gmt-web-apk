import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'float_button_store.g.dart';

class FloatButtonStore = _FloatButtonStore with _$FloatButtonStore;

abstract class _FloatButtonStore with Store {
  @observable
  FloatButtonState state = FloatButtonState.add;

  @observable
  VoidCallback action = () {};
}

enum FloatButtonState { add, update }
