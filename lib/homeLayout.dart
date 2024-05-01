import 'package:animation/cubit.dart';
import 'package:animation/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => AppCubit()..create(),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context,state)=> Scaffold(
        appBar: AppBar(),
        body: AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(items:
          AppCubit.get(context).nav,
          currentIndex: AppCubit.get(context).currentIndex,
          onTap: (index){
          AppCubit.get(context).change(index);
          },
        ),
      ), listener: (context,state){}),
    );
  }
}
