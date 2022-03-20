import 'package:flutter/material.dart';
import 'package:gmt/app/app.dart';
import 'package:gmt/app/store/session/session.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [Provider<Session>(create: (_) => Session())],
      child: const App(),
    ));
