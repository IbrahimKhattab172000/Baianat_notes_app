// ignore_for_file: file_names, avoid_print

import 'package:baianat/controllers/deepLinkService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../models/noteModel.dart';

class NoteController extends GetxController {
  NoteModel noteModel = NoteModel.emptyData();
  RxBool loading = false.obs;

  RxList<NoteModel> noteList = RxList<NoteModel>();
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> bodyController = TextEditingController().obs;
  final deepLinkService = Get.find<DeepLinkService>();

  // ignore: invalid_use_of_protected_member
  List<NoteModel> get notes => noteList.value;

  @override
  void onInit() {
    // String? uid = Get.find<AuthController>().user?.uid;
    // print("NoteController onit :: $uid");
    // noteList
    //     .bindStream(Database().noteStream(uid!)); //stream coming from firebase
    getNotes();

    super.onInit();
  }

  void configureTextControllers() {
    titleController.value.text = noteModel.title ?? '';
    bodyController.value.text = noteModel.body ?? '';
  }

  Future<void> addNotes() async {
    int id = 0;
    QuerySnapshot querySnapShot =
        await FirebaseFirestore.instance.collection("notes").get();
    if (querySnapShot.docs.isNotEmpty) {
      id = querySnapShot.docs.last.get('id') + 1;
    }
    await FirebaseFirestore.instance
        .collection("notes")
        .doc(id.toString())
        .set({
      "id": id,
      "title": titleController.value.text,
      "body": bodyController.value.text,
      "date": DateTime.now().toString(),
    });
    Get.back();
  }

  Future<void> editNote() async {
    await FirebaseFirestore.instance
        .collection("notes")
        .doc(noteModel.id.toString())
        .update({
      'id': noteModel.id,
      "title": titleController.value.text,
      "body": bodyController.value.text,
      "date": DateTime.now().toString(),
    });
    Get.back();
    Get.back();
  }

  List<NoteModel> getNotes() {
    Stream<QuerySnapshot<Map<String, dynamic>>> notesStream =
        FirebaseFirestore.instance.collection("notes").snapshots();
    notesStream.forEach((element) {
      notes.clear();
      element.docs.forEach((doc) {
        noteList.add(NoteModel.fromDocumentSnapshot(doc));
      });
    });

    return notes;
  }

  Future<void> shareLink() async {
    await deepLinkService.createDeepLink(noteModel).then((value) {
      print(value.toString());
      Share.share(value.shortUrl.toString());
    });
  }

  Future<void> getNoteDetail(String id) async {
    loading.value = true;
    DocumentSnapshot docSnapShot =
        await FirebaseFirestore.instance.collection("notes").doc(id).get();
    if (docSnapShot.exists) {
      noteModel.id = docSnapShot.get('id');
      noteModel.title = docSnapShot.get('title');
      noteModel.body = docSnapShot.get('body');
      noteModel.date = docSnapShot.get('date');
      loading.value = false;
    }
  }
}
