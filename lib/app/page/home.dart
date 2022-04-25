import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmt/app/store/float_button_store/float_button_store.dart';
import 'package:provider/provider.dart';

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final floatButtonStore = Provider.of<FloatButtonStore>(context);
    useEffect(() {
      floatButtonStore.state = FloatButtonState.none;
      return null;
    }, []);

    return Expanded(
      child: Center(
        child: Text("Nada que mostrar"),
      ),
    );
  }
}
