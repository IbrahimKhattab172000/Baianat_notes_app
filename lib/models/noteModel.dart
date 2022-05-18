// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  int? id;
  String? title;
  String? body;
  String? date;

  NoteModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.date});

  NoteModel.fromDocumentSnapshot(QueryDocumentSnapshot documentSnapshot) {
    id = documentSnapshot.get('id') ?? 0;
    title = documentSnapshot.get('title') ?? '';
    body = documentSnapshot.get("body") ?? '';
    date = documentSnapshot.get("date") ?? '';
  }

  NoteModel.emptyData() {
    id = 0;
    title = '';
    body = '';
    date = '';
  }

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json["body"];
    date = json["date"];
  }
}
