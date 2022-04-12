// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'float_button_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FloatButtonStore on _FloatButtonStore, Store {
  final _$stateAtom = Atom(name: '_FloatButtonStore.state');

  @override
  FloatButtonState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(FloatButtonState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$actionAtom = Atom(name: '_FloatButtonStore.action');

  @override
  VoidCallback get action {
    _$actionAtom.reportRead();
    return super.action;
  }

  @override
  set action(VoidCallback value) {
    _$actionAtom.reportWrite(value, super.action, () {
      super.action = value;
    });
  }

  @override
  String toString() {
    return '''
state: ${state},
action: ${action}
    ''';
  }
}
