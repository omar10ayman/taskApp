import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:utasks/bolc/cubits.dart';
import 'package:utasks/bolc/states.dart';
import 'package:utasks/shared/componat.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scafoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();
    var titleControl = TextEditingController();
    var dateControl = TextEditingController();
    var timeControl = TextEditingController();
    return BlocProvider(
      create: ((context) => AppCubits()..createDatabase()),
      child: BlocConsumer<AppCubits, AppStates>(listener: (context, state) {
        // if (state is insertDBState) {
        //   Navigator.pop(context);
        // }
      }, builder: (context, state) {
        AppCubits cubit = AppCubits.get(context);
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 176, 81, 13),
              title: Text(cubit.appBar[cubit.currentindex])),
          key: scafoldKey,
          backgroundColor: Color.fromARGB(255, 36, 34, 34),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 176, 81, 13),
              onPressed: () {
                if (cubit.isshowbottonSheet) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertDB(
                        title: titleControl.text,
                        date: dateControl.text,
                        time: timeControl.text);
                    cubit.showButtonSheet(ishow: false, icon: Icons.add);
                    Navigator.pop(context);
                    timeControl.text = "";
                    dateControl.text = "";
                    titleControl.text = "";
                    // cubit.editItem(icon: Icons.add, iss: false);
                  }
                } else {
                  cubit.showButtonSheet(ishow: true, icon: Icons.done_all);

                  // don't put bliulder in show button
                  scafoldKey.currentState
                      ?.showBottomSheet((context) => Form(
                            key: formKey,
                            child: Container(
                              color: Color.fromARGB(255, 134, 131, 135),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaulttextformfield(
                                      onchage: (v) {
                                        v = titleControl.text;
                                      },
                                      controller: titleControl,
                                      label: "Title",
                                      valide: (v) {
                                        if (v.isEmpty) {
                                          return "Must Put value";
                                        }
                                      }),
                                  sizedBox(),
                                  defaulttextformfield(
                                      ontab: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2040))
                                            .then((value) {
                                          dateControl.text =
                                              DateFormat.MMMEd().format(value!);
                                        });
                                      },
                                      controller: dateControl,
                                      label: "Date",
                                      valide: (v) {
                                        if (v.isEmpty) {
                                          return "Must Put value";
                                        }
                                      }),
                                  sizedBox(),
                                  defaulttextformfield(
                                      ontab: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeControl.text =
                                              value!.format(context);
                                        });
                                      },
                                      controller: timeControl,
                                      label: "Time",
                                      valide: (v) {
                                        if (v.isEmpty) {
                                          return "Must Put value";
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.showButtonSheet(ishow: false, icon: Icons.add);
                  });
                }
              },
              child: Icon(cubit.iconFloat)),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Color.fromARGB(255, 176, 81, 13),
              backgroundColor: Color.fromARGB(255, 138, 135, 135),
              currentIndex: cubit.currentindex,
              onTap: (v) {
                cubit.currentindex = v;
                cubit.currentindexFunc(cubit.currentindex);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.task),
                  label: "NEW",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: "DONE"),
              ]),
          body: cubit.screen[cubit.currentindex],
        );
      }),
    );
  }
}
