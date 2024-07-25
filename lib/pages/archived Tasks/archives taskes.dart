import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Shaerd/Cubit/States.dart';
import 'package:todo_app/Shaerd/Cubit/cubit.dart';
import 'package:todo_app/Shaerd/widget/New%20Task%20Item.dart';

class ArchivesTasksScreen extends StatelessWidget {
  const ArchivesTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,HomePageState>(
      listener: (context,state){},
      builder: (context,state)
      {
        var tasks = AppCubit.getObject(context).archiveTasks ;
        return ListView.separated(
            itemBuilder: (context, index) {
              return buildTaskItem(tasks[index],context);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                indent: 10,
                thickness: 0.8,
                endIndent: 10,
                color: Colors.grey,
              );
            },
            itemCount: tasks.length);
      },
    );
  }
}
//
