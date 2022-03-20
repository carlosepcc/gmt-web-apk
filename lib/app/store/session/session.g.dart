// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Session on _Session, Store {
  Computed<bool>? _$isInSessionComputed;

  @override
  bool get isInSession => (_$isInSessionComputed ??=
          Computed<bool>(() => super.isInSession, name: '_Session.isInSession'))
      .value;

  final _$jwtAtom = Atom(name: '_Session.jwt');

  @override
  String? get jwt {
    _$jwtAtom.reportRead();
    return super.jwt;
  }

  @override
  set jwt(String? value) {
    _$jwtAtom.reportWrite(value, super.jwt, () {
      super.jwt = value;
    });
  }

  final _$usernameAtom = Atom(name: '_Session.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_Session.init');

  @override
  Future init({String? token}) {
    return _$initAsyncAction.run(() => super.init(token: token));
  }

  @override
  String toString() {
    return '''
jwt: ${jwt},
username: ${username},
isInSession: ${isInSession}
    ''';
  }
}
