import 'package:animation/cubit.dart';
import 'package:animation/dataScreen.dart';
import 'package:animation/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bla extends StatelessWidget {
  const Bla({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state) => Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(itemBuilder:
                    (context,index)=>dataItem(AppCubit.get(context).done[index], context),
                    separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                    itemCount: AppCubit.get(context).done.length
                ),
              )
            ],
          ),
        ),
        listener: (context,state){}
    );
  }
}
