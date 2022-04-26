// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocalStore on _LocalStore, Store {
  final _$localesAtom = Atom(name: '_LocalStore.locales');

  @override
  List<Local>? get locales {
    _$localesAtom.reportRead();
    return super.locales;
  }

  @override
  set locales(List<Local>? value) {
    _$localesAtom.reportWrite(value, super.locales, () {
      super.locales = value;
    });
  }

  final _$listAsyncAction = AsyncAction('_LocalStore.list');

  @override
  Future<bool> list(BuildContext context) {
    return _$listAsyncAction.run(() => super.list(context));
  }

  final _$_LocalStoreActionController = ActionController(name: '_LocalStore');

  @override
  Future<bool> Function() save(BuildContext context, {required String number}) {
    final _$actionInfo =
        _$_LocalStoreActionController.startAction(name: '_LocalStore.save');
    try {
      return super.save(context, number: number);
    } finally {
      _$_LocalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> Function() delete(BuildContext context,
      {required List<int> ids}) {
    final _$actionInfo =
        _$_LocalStoreActionController.startAction(name: '_LocalStore.delete');
    try {
      return super.delete(context, ids: ids);
    } finally {
      _$_LocalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> Function() update(BuildContext context,
      {required int id, required String number}) {
    final _$actionInfo =
        _$_LocalStoreActionController.startAction(name: '_LocalStore.update');
    try {
      return super.update(context, id: id, number: number);
    } finally {
      _$_LocalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locales: ${locales}
    ''';
  }
}
