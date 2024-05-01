
import 'package:animation/blocObserve.dart';
import 'package:animation/cubit.dart';
import 'package:animation/homeLayout.dart';
import 'package:animation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget  {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppCubit()..create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeLayout()
      ),
    );
  }
}
