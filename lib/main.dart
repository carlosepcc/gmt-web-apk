import 'package:flutter/material.dart';
import 'package:gmt/app/app.dart';
import 'package:gmt/app/store/float_button_store/float_button_store.dart';
import 'package:gmt/app/store/local/local_store.dart';
import 'package:gmt/app/store/session/session.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        Provider<Session>(create: (_) => Session()),
        Provider<FloatButtonStore>(create: (_) => FloatButtonStore()),
        Provider<LocalStore>(create: (_) => LocalStore()),
      ],
      child: App(),
    ));
