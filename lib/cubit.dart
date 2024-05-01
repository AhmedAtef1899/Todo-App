
import 'dart:io';
import 'dart:math';

import 'package:animation/bla.dart';
import 'package:animation/dataScreen.dart';
import 'package:animation/home_screen.dart';
import 'package:animation/state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;

  List<Widget> screens =
  [
    HomeScreen(),
    const DataScreen(),
    const Bla()
  ];

  int currentIndex = 0;

  List<BottomNavigationBarItem> nav =
  [
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'home'),
    const BottomNavigationBarItem(icon: Icon(Icons.data_usage_sharp),label: 'tasks'),
    const BottomNavigationBarItem(icon: Icon(Icons.done_outline_outlined),label: 'done'),
  ];

  File? image;
  void pickImage()
  async {
    final picker = ImagePicker();
    final imagePicker = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicker != null)
      {
        image = File(imagePicker.path);
        emit(AppPickState());
      }
  }

  void change(int index)
  {
    currentIndex = index;
    emit(AppChangeState());
  }

  List<Map> data=[];
  List<Map> done=[];
  void create()
  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
        {
          database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, name TEXT, phone TEXT)')
          .then((value){
            emit(AppCreateSuccessState());
          }).catchError((onError){
            emit(AppCreateErrorState());
          });
        },
        onOpen: (database)
        {
          getData(database);
          print('dataOpened');
        }
    ).then((value){
      database = value;
      emit(AppCreateState());
    });
  }

  void getData(database)
  {
    database?.rawQuery('SELECT * FROM tasks').then((value){
      data = value;
      print (value.toString());
      emit(AppGetState());
    });
  }

  Future insert({required String name,required String phone}) async
  {
    return await database?.transaction((txn) => txn.rawInsert(
      'INSERT INTO tasks(name,phone) VALUES("$name","$phone")'
    ).then((value) {
      getData(database);
      print(value.toString());
      emit(AppInsertedSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(AppInsertedErrorState());
    }));
  }
  void delete({required int id})
  {
    database?.rawDelete('DELETE FROM tasks WHERE id = ?',[id]).then((value){
      getData(database);
      emit(AppDeleteState());
    });
  }

}



