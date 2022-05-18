// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:baianat/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/noteController.dart';
import 'add_note.dart';
import 'note_list.dart';

class HomePage extends GetWidget<NoteController> {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kMainLightColor,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Baianat Notes",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GetX<NoteController>(
                    init: Get.put<NoteController>(NoteController()),
                    builder: (NoteController noteController) {
                      if (noteController != null &&
                          noteController.notes != null) {
                        return NoteList();
                      } else {
                        return Text("No notes, create some ");
                      }
                    }),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: "Add Note",
          onPressed: () {
            Get.to(() => AddNotePage());
          },
          child: Icon(
            Icons.note_add,
            size: 30,
          )),
    );
  }
}
