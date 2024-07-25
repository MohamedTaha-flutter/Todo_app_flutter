import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Shaerd/Cubit/States.dart';
import 'package:todo_app/pages/Done%20Taskes/Done%20taskes.dart';
import 'package:todo_app/pages/New%20Taskes/New%20taskes.dart';
import 'package:todo_app/pages/archived%20Tasks/archives%20taskes.dart';

class AppCubit extends Cubit<HomePageState> {
  AppCubit() : super(InitialState());

  static AppCubit getObject(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivesTasksScreen(),
  ];
  List<String> appBarTitle = ["New Tasks", "Done Tasks", "Archive Tasks"];

  void changeScreen(int index) {
    currentIndex = index;
    emit(ChangeButtonNavBar());
  }

  bool showButtonSheet = false;

  IconData iconflo = Icons.edit;

  void changeButtonSheetState({required IconData icon, required bool isShow}) {
    showButtonSheet = isShow;
    iconflo = icon;
    emit(AppChangeButtonSheetState());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database, version) {
        print("database created");
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT, data TEXT, time TEXT, status TEXT )')
            .then((value) {
          print("table created");
        }).catchError((error) {
          print("Error When Created database ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  insertDatabase({
    @required String? title,
    @required String? date,
    @required String? time,
  }) async {
    await database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, data, time, status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print("$value inserted successfully ");
        emit(InsertDatabaseState());
        getDataFromDatabase(database) ;
      }).catchError((error) {
        print("Error When Inserted New Record ${error.toString()}");
      });
    });
  }

  void getDataFromDatabase(database)  {
    List<Map> newTasks = [];
    List<Map> doneTasks = [];
    List<Map> archiveTasks = [];
     database!.rawQuery('SELECT * FROM tasks').then((value) {
      emit(GetDatabaseState());

      value.forEach((element)
      {
        if(element['status'] == 'new')
        {
          newTasks.add(element) ;
        }
        else if (element['status'] == 'done')
        {
          doneTasks.add(element) ;
        }
        else {
          archiveTasks.add(element) ;
        }
      });

    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      emit(UpdateDatabaseState());
    });
  }
}
