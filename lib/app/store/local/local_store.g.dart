// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocalStore on _LocalStore, Store {
  final _$localesAtom = Atom(name: '_LocalStore.locales');

  @override
  List<Local> get locales {
    _$localesAtom.reportRead();
    return super.locales;
  }

  @override
  set locales(List<Local> value) {
    _$localesAtom.reportWrite(value, super.locales, () {
      super.locales = value;
    });
  }

  final _$listAsyncAction = AsyncAction('_LocalStore.list');

  @override
  Future<bool> list({required BuildContext context}) {
    return _$listAsyncAction.run(() => super.list(context: context));
  }

  @override
  String toString() {
    return '''
locales: ${locales}
    ''';
  }
}
