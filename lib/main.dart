import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_app/middlewares/fetch_posts_middleware.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux_app/actions/actions.dart';
import 'package:flutter_redux_app/actions/color_action.dart';
import 'package:flutter_redux_app/pages/posts_page.dart';
import 'package:flutter_redux_app/reducers/reducers.dart';
import 'package:flutter_redux_app/states/states.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
      colorState: ColorState(color: Colors.red),
      counterState: CounterState(counter: 0),
      postsState: PostsState.initial(),
      postState: PostState.initial(),
    ),
    middleware: [thunkMiddleware],
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Redux',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ColorCounterViewModel>(
      converter: (store) {
        return _ColorCounterViewModel(
          state: store.state,
          onColorChanged: () {
            print('onColorChanged');
            return store.dispatch(ChangeColorAction());
          },
          onCounterIncremented: () => store
              .dispatch(IncrementAction(color: store.state.colorState.color)),
          onCounterDecremented: () => store
              .dispatch(DecrementAction(color: store.state.colorState.color)),
        );
      },
      builder: (BuildContext context, _ColorCounterViewModel colorCounterVM) {
        return Scaffold(
          backgroundColor: colorCounterVM.state.colorState.color,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text(
                    'Posts',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PostsPage();
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${colorCounterVM.state.counterState.counter}',
                  style: TextStyle(fontSize: 48.0),
                ),
                ElevatedButton(
                  onPressed: colorCounterVM.onColorChanged,
                  child: Text(
                    'Change Color',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
              bottom: 15.0,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'btn1',
                    onPressed: colorCounterVM.onCounterIncremented,
                    child: Icon(Icons.add),
                  ),
                  SizedBox(width: 5.0),
                  FloatingActionButton(
                    heroTag: 'btn2',
                    onPressed: colorCounterVM.onCounterDecremented,
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return StoreConnector<AppState, _ColorViewModel>(
  //     converter: (store) {
  //       return _ColorViewModel(
  //         state: store.state.colorState,
  //         onColorChanged: () {
  //           print('onColorChanged');
  //           return store.dispatch(ChangeColorAction());
  //         },
  //       );
  //     },
  //     builder: (BuildContext context, _ColorViewModel colorVM) {
  //       return StoreConnector<AppState, _CounterViewModel>(converter: (store) {
  //         return _CounterViewModel(
  //           state: store.state.counterState,
  //           onCounterIncremented: () =>
  //               store.dispatch(IncrementAction(color: colorVM.state.color)),
  //           onCounterDecremented: () =>
  //               store.dispatch(DecrementAction(color: colorVM.state.color)),
  //         );
  //       }, builder: (context, _CounterViewModel counterVM) {
  //         return Scaffold(
  //           backgroundColor: colorVM.state.color,
  //           appBar: AppBar(
  //             backgroundColor: Colors.transparent,
  //             elevation: 0,
  //             actions: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: ElevatedButton(
  //                   child: Text(
  //                     'Posts',
  //                     style: TextStyle(fontSize: 18.0),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(builder: (context) {
  //                         return PostsPage();
  //                       }),
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //           body: Center(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   '${counterVM.state.counter}',
  //                   style: TextStyle(fontSize: 48.0),
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: colorVM.onColorChanged,
  //                   child: Text(
  //                     'Change Color',
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           floatingActionButton: Padding(
  //             padding: const EdgeInsets.only(
  //               right: 15.0,
  //               bottom: 15.0,
  //             ),
  //             child: Align(
  //               alignment: Alignment.bottomRight,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   FloatingActionButton(
  //                     heroTag: 'btn1',
  //                     onPressed: counterVM.onCounterIncremented,
  //                     child: Icon(Icons.add),
  //                   ),
  //                   SizedBox(width: 5.0),
  //                   FloatingActionButton(
  //                     heroTag: 'btn2',
  //                     onPressed: counterVM.onCounterDecremented,
  //                     child: Icon(Icons.remove),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }
}

class _ColorViewModel {
  final ColorState state;
  final void Function() onColorChanged;
  _ColorViewModel({
    required this.state,
    required this.onColorChanged,
  });
}

class _CounterViewModel {
  final CounterState state;
  final void Function() onCounterIncremented;
  final void Function() onCounterDecremented;
  _CounterViewModel({
    required this.state,
    required this.onCounterIncremented,
    required this.onCounterDecremented,
  });
}

class _ColorCounterViewModel {
  final AppState state;
  final void Function() onColorChanged;
  final void Function() onCounterIncremented;
  final void Function() onCounterDecremented;
  _ColorCounterViewModel({
    required this.state,
    required this.onColorChanged,
    required this.onCounterIncremented,
    required this.onCounterDecremented,
  });
}
