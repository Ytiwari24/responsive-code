// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'home_page.dart';

// void main() async {
//   await ScreenUtil.ensureScreenSize();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context, designSize: const Size(360, 800));
//     return GetMaterialApp(
//       title: 'Your App Title',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 30.sp)),
//       ),
//       home: const HomePage(title: 'H O M E   P A G E'),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/bloc/theme_cubit.dart';
import 'src/view/app_view.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const App());
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: 
      const AppView(),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   Bloc.observer = const AppBlocObserver();
//   runApp(const App());
// }

// class AppBlocObserver extends BlocObserver {
//   const AppBlocObserver();

//   @override
//   void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
//     super.onChange(bloc, change);
//     if (bloc is Cubit) print(change);
//   }

//   @override
//   void onTransition(
//     Bloc<dynamic, dynamic> bloc,
//     Transition<dynamic, dynamic> transition,
//   ) {
//     super.onTransition(bloc, transition);
//     print(transition);
//   }
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ThemeCubit(),
//       child: const AppView(),
//     );
//   }
// }

// class AppView extends StatelessWidget {
//   const AppView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeCubit, ThemeData>(
//       builder: (_, theme) {
//         return MaterialApp(
//           theme: theme,
//           home: const CounterPage(),
//         );
//       },
//     );
//   }
// }

// class CounterPage extends StatelessWidget {
//   const CounterPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CounterBloc(),
//       child: const CounterView(),
//     );
//   }
// }

// class CounterView extends StatelessWidget {
//   const CounterView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Counter')),
//       body: Center(
//         child: BlocBuilder<CounterBloc, int>(
//           builder: (context, count) {
//             return Text(
//               '$count',
//               style: Theme.of(context).textTheme.displayLarge,
//             );
//           },
//         ),
//       ),
//       floatingActionButton: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           FloatingActionButton(
//             child: const Icon(Icons.add),
//             onPressed: () {
//               context.read<CounterBloc>().add(CounterIncrementPressed());
//             },
//           ),
//           const SizedBox(height: 4),
//           FloatingActionButton(
//             child: const Icon(Icons.remove),
//             onPressed: () {
//               context.read<CounterBloc>().add(CounterDecrementPressed());
//             },
//           ),
//           const SizedBox(height: 4),
//           FloatingActionButton(
//             child: const Icon(Icons.brightness_6),
//             onPressed: () {
//               context.read<ThemeCubit>().toggleTheme();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Event being processed by [CounterBloc].
// abstract class CounterEvent {}

// /// Notifies bloc to increment state.
// class CounterIncrementPressed extends CounterEvent {}

// /// Notifies bloc to decrement state.
// class CounterDecrementPressed extends CounterEvent {}

// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0) {
//     on<CounterIncrementPressed>((event, emit) => emit(state + 1));
//     on<CounterDecrementPressed>((event, emit) => emit(state - 1));
//   }
// }

// class ThemeCubit extends Cubit<ThemeData> {
//   ThemeCubit() : super(_lightTheme);

//   static final _lightTheme = ThemeData.light();

//   static final _darkTheme = ThemeData.dark();

//   /// Toggles the current brightness between light and dark.
//   void toggleTheme() {
//     emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
//   }
// }
