import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Shaerd/Cubit/States.dart';
import 'package:todo_app/Shaerd/Cubit/cubit.dart';
import 'package:todo_app/Shaerd/widget/constans.dart';
import 'package:todo_app/pages/Done%20Taskes/Done%20taskes.dart';
import 'package:todo_app/pages/New%20Taskes/New%20taskes.dart';
import 'package:todo_app/pages/archived%20Tasks/archives%20taskes.dart';


class HomePage extends StatelessWidget {



  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();



  var titleController = TextEditingController();

  var timeController = TextEditingController();
  var dateController = TextEditingController();


  HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..createDatabase(),

      child: BlocConsumer<AppCubit , HomePageState>(
        listener: (context,state)
        {
          if(state is InsertDatabaseState )
          {
            Navigator.pop(context);
          }
        },
        builder: (context , state)
        {
          AppCubit object = BlocProvider.of(context) ;
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                object.appBarTitle[object.currentIndex],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (object.showButtonSheet)
                {
                  if (formKey.currentState!.validate())
                  {
                    object.insertDatabase(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text) ;
                    // insertDatabase(
                    //     title: titleController.text,
                    //     date: dateController.text,
                    //     time: timeController.text
                    // ).then((value) {
                    //   Navigator.pop(context);
                    //   showButtonSheet = false;
                    //   // setState(() {
                    //   //   iconflo = Icons.edit;
                    //   // });
                    // });
                  }
                } else {
                  scaffoldKey.currentState?.showBottomSheet((context) => Container(
                    width: double.infinity,
                    color: Colors.grey[100],
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Title must not be Empty";
                              }
                              null;
                            },
                            decoration: const InputDecoration(
                              label: Text("New Task"),
                              prefixIcon: Icon(Icons.task),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: timeController,
                            keyboardType: TextInputType.datetime,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Task Time must not be Empty";
                              }
                              return null;
                            },
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                timeController.text =
                                "${value?.format(context).toString()}";
                              }).catchError((error) {
                                print("Error at sow time Picker  $error");
                              });
                            },
                            decoration: const InputDecoration(
                              label: Text("Task time "),
                              prefixIcon: Icon(Icons.watch_later_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Task date must not be Empty";
                              }
                              return null;
                            },
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse("2090-12-29"),
                              ).then((value) {
                                dateController.text = value.toString();
                              }).catchError((error) {
                                print(" Error at show date picker $error");
                              });
                            },
                            decoration: const InputDecoration(
                              label: Text("date time "),
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).closed.then((value)
                  {
                    object.changeButtonSheetState(icon: Icons.edit, isShow: false) ;
                  });
                object.changeButtonSheetState(icon: Icons.add, isShow: true);
                }
              },
              child: Icon(object.iconflo),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
             object.changeScreen(index) ;
              },
              currentIndex: object.currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archive",
                ),
              ],
            ),
            body:  object.screens[object.currentIndex],
          );
        },
      ),
    );
  }


}
