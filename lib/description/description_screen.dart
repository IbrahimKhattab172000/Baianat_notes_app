// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:baianat/constants.dart';
import 'package:baianat/controllers/noteController.dart';
import 'package:baianat/home/edit_note.dart';
import 'package:baianat/login/login_screen.dart';
import 'package:baianat/shared/shared_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescriptionScreen extends GetView<NoteController> {
  const DescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kMainLightColor,
      appBar: AppBar(
          backgroundColor: MyColors.kMainLightColor,
          title: Text("Note description"),
          leading: IconButton(
            onPressed: () {
              Get.to(() => EditNote());
            },
            icon: Icon(Icons.edit),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.shareLink();
              },
              icon: Icon(Icons.share),
            ),
          ]),
      body: Obx(() => controller.loading.value
          ? Center(
              child: Text('loading...'),
            )
          : Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 200,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            controller.noteModel.title ?? '',
                            style: TextStyle(
                              color: MyColors.kMainLightColor,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                controller.noteModel.body ?? '',
                                style: TextStyle(
                                  color: MyColors.kMainLightColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
