import 'package:flutter/material.dart';
import 'package:todo_app/Shaerd/Cubit/cubit.dart';

Widget buildTaskItem(Map model, context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              "${model['time']}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model['title']}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${model['data']}",
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: ()
              {
                AppCubit.getObject(context).updateData(
                    status: "Done",
                    id: model['id'],
                ) ;
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: ()
              {
                AppCubit.getObject(context).updateData(
                    status: "Archive",
                    id: model['id'] ,
                ) ;
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black54,
              )),
        ],
      ),
    );
