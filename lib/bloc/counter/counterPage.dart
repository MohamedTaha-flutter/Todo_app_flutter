import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/counter/logic.dart';
import 'package:todo_app/bloc/counter/state.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CounterCubit();
      },
      child: BlocConsumer<CounterCubit, CounterState>(
          listener: (context, state) {},
          builder: (context, state)
          {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Counter App ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: ()
                        {
                          CounterCubit.getObject(context).munsC() ;
                        },
                        color: Colors.tealAccent,
                        child: const Text(
                          "Muns",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "${CounterCubit.getObject(context).c} ",
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      MaterialButton(
                        onPressed: ()
                        {
                          CounterCubit.getObject(context).plusC() ;
                        },
                        color: Colors.tealAccent,
                        child: const Text(
                          "Plus",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    onPressed: ()
                    {
                      CounterCubit.getObject(context).ResetC() ;
                    },
                    color: Colors.tealAccent,
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ) ;
          }
      )
    );
  }
}
