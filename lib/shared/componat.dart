import 'package:flutter/material.dart';
import 'package:utasks/bolc/cubits.dart';

Widget defaulttextformfield({
  required dynamic controller,
  required String label,
  double raduis = 15.0,
  IconButton? suffix,
  bool ispass = false,
  required Function valide,
  Function? onchage,
  Function? ontab,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (s) {
          return valide(s); // must be put return and put s in ()
        },
        onChanged: (v) {
          // ignore: void_checks
          return onchage!(v);
        },
        onTap: () {
          ontab!();
        },
        controller: controller,
        obscureText: ispass,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          suffixIcon: suffix,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 176, 81, 13),
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(raduis))),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(raduis))),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        ),
      ),
    );
Widget sizedBox() => const SizedBox(height: 10);

Widget putDB(task, context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: const Color.fromARGB(255, 138, 135, 135),
            child: Text("${task["date"]}",
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${task["title"]}",
                  style: const TextStyle(fontSize: 35, color: Colors.white),
                ),
                sizedBox(),
                Text("${task["time"]}",
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
          ),

          IconButton(
              onPressed: () {
                // نستدعلى البلوك كدة مش نعمل bolc comsuer
                AppCubits.get(context).updateDb(s: "done", id: task["id"]);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),

          IconButton(
              onPressed: () {
                // نستدعلى البلوك كدة مش نعمل bolc comsuer
                AppCubits.get(context).deletDb(id: task["id"]);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )),
          // SizedBox(
          //   width: 10,
          // ),
          // IconButton(
          //     onPressed: () {
          //       // نستدعلى البلوك كدة مش نعمل bolc comsuer
          //       // AppCubits.get(context).editItem();
          //     },
          //     icon: Icon(
          //       Icons.edit,
          //       color: Colors.red,
          //     )),
        ],
      ),
    );
