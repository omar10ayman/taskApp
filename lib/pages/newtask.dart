import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utasks/bolc/cubits.dart';
import 'package:utasks/bolc/states.dart';
import 'package:utasks/shared/componat.dart';

class New extends StatelessWidget {
  const New({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubits, AppStates>(
        builder: (context, state) {
          AppCubits tasks = AppCubits.get(context)..newTask;
          return ListView.separated(
              itemBuilder: (context, index) =>
                  putDB(tasks.newTask[index], context),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
              itemCount: tasks.newTask.length);
        },
        listener: (context, state) {});
  }
}
