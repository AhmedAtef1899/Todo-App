
import 'package:animation/cubit.dart';
import 'package:animation/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context,state)=>Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(itemBuilder: (context,index) => dataItem(AppCubit.get(context).data[index],context),
                  separatorBuilder: (context,index)=>const SizedBox(height: 2,),
                  itemCount: AppCubit.get(context).data.length
              ),
            )
          ],
        ),
      ),
    ), listener: (context,state){});
  }
}

Widget dataItem(Map model,context) =>Padding(
  padding: const EdgeInsets.all(20),
  child: Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (id){
      AppCubit.get(context).delete(id: model['id']);
    },
    child: Row(
      children: [
        const CircleAvatar(
          radius: 30,
          child: Icon(
              Icons.person
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Text(
               model['name']
            ),
            const SizedBox(
              height:10
            ),
            Text(
                model['phone']
            ),
          ],
        ),
        const Spacer(),

        IconButton(onPressed: (){
          AppCubit.get(context).data.forEach((element) {
            AppCubit.get(context).done.add(element);
          });
        }, icon:const Icon(
          Icons.done
        ))
      ],
    ),
  ),
);


