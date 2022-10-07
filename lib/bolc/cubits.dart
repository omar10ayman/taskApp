import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:utasks/bolc/states.dart';
import 'package:utasks/pages/donetask.dart';
import 'package:utasks/pages/newtask.dart';

class AppCubits extends Cubit<AppStates> {
  AppCubits() : super(initailState());
  static AppCubits get(context) => BlocProvider.of(context);
  int currentindex = 0;
  currentindexFunc(int index) {
    currentindex = index;
    emit(currentIndexState());
  }

  List<Widget> screen = [New(), Done()];
  List<String> appBar = ["New Task", "Done Task"];
  // void screens(int i) {
  //   currentindex = i;
  //   emit(screenState());
  // }

  bool isshowbottonSheet = false;
  IconData iconFloat = Icons.add;
  // لازم نربطهم ببعض عشان دالة if
  showButtonSheet({required ishow, required icon}) {
    isshowbottonSheet = ishow;
    iconFloat = icon;
    emit(showButtonState());
  }

  // editItem({
  //   iss,
  //   icon,
  // }) {
  //   isshowbottonSheet = iss;
  //   iconFloat = icon;
  //   emit(editState());
  // }

  late Database db;
  void createDatabase() async {
    openDatabase(
      "tasks.db",
      onCreate: (db, version) async {
        print("create db");
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT , date TEXT,status TEXT)')
            .then((value) {
          print("Creat Table");
        });
      },
      onOpen: (db) {
        print("OPENED");
        getDB(db);
      },
      version: 1,
    ).then((value) {
      db = value;
      emit(createDBState());
    });
  }

  insertDB({
    required title,
    required date,
    required time,
  }) async {
    db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, time, date,status) VALUES("$title", "$date", "$time","new")')
          .then((value) {
        emit(insertDBState());
        getDB(db);
      });
    });
  }

  List<Map> newTask = [];
  List<Map> doneTask = [];
  void getDB(Database db) async {
    newTask = [];
    doneTask = [];
    db.rawQuery('SELECT * FROM tasks').then((value) {
      for (var e in value) {
        if (e["status"] == "new") {
          newTask.add(e);
        }
        if (e["status"] == "done") {
          doneTask.add(e);
        }
      }

      emit(getDBState());
    });
  }

  updateDb({required String s, required int id}) {
    db.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [s, id]).then(
        (value) {
      emit(updateDBState());
      getDB(db);
    });
  }

  deletDb({required int id}) {
    db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(deleteDBState());
      getDB(db);
    });
  }
}
