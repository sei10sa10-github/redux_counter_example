import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store(counterReducer, initialState: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoreProvider(
            store: store,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('Redux Demo'),
                ),
                body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You have pushed the button this many times:'),
                        StoreConnector<int, String>(
                            converter: (store) => store.state.toString(),
                            builder: (context, count) => Text(count,
                                style: Theme.of(context).textTheme.display1))
                      ]),
                ),
                floatingActionButton: StoreConnector<int, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(ActionIncrement());
                  },
                  builder: (context, callback) {
                    return FloatingActionButton(
                      onPressed: callback,
                      child: Icon(Icons.add),
                    );
                  }
              )
            )
          )
    );
  }
}

int counterReducer(int state, action) {
  if (action is ActionIncrement) {
    return ++state;
  }

  return state;
}

class ActionIncrement {}
