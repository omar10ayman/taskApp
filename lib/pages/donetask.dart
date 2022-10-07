import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utasks/bolc/cubits.dart';
import 'package:utasks/bolc/states.dart';
import 'package:utasks/shared/componat.dart';

class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubits, AppStates>(
        builder: (context, state) {
          AppCubits tasks = AppCubits.get(context)..doneTask;
          return ListView.separated(
              itemBuilder: (context, index) =>
                  putDB(tasks.doneTask[index], context),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
              itemCount: tasks.doneTask.length);
        },
        listener: (context, state) {});
  }
}
