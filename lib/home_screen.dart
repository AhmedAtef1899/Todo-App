import 'dart:io';

import 'package:animation/cubit.dart';
import 'package:animation/dataScreen.dart';
import 'package:animation/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state)=>Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(50),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Empty';
                    }
                    return null;
                  },
                  decoration:  const InputDecoration(
                      labelText: 'name'
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneController,
                  onChanged: (value){

                  },
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Empty';
                    }
                    return null;
                  },
                  decoration:  const InputDecoration(
                      labelText: 'phone'
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(onPressed: (){
                    if (formKey.currentState!.validate())
                      {
                        AppCubit.get(context).insert(name: nameController.text, phone: phoneController.text);
                        nameController.text = '';
                        phoneController.text = '';
                      }
                  }, child:
                  const Text(
                    'Add Data',
                    style: TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.white
                    ),
                  )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
        listener: (context,state){}
    );
  }
}






