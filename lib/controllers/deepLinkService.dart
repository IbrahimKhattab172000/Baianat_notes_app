// ignore_for_file: file_names

import 'dart:developer';

import 'package:baianat/controllers/noteController.dart';
import 'package:baianat/description/description_screen.dart';
import 'package:baianat/models/noteModel.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

class DeepLinkService extends GetxService {
  Future<DeepLinkService> init() async {
    retriveDeepLink();
    return this;
  }

  Future<ShortDynamicLink> createDeepLink(NoteModel noteModel) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: "https://baianat172000.page.link",
        link:
            Uri.parse("https://baianat172000.page.link.com?id=${noteModel.id}"),
        iosParameters: IosParameters(bundleId: "com.example.baianat"),
        androidParameters: AndroidParameters(
            packageName: "com.example.baianat", minimumVersion: 1),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: noteModel.title, description: noteModel.body));

    final url = await parameters.buildShortLink();
    return url;
  }

  Future<void> retriveDeepLink() async {
    PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      navigate(data);
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? data) async {
      navigate(data);
    });
  }

  void navigate(PendingDynamicLinkData? data) async {
    log(data!.link.queryParameters['id'].toString());

    if (data.link.queryParameters.containsKey('id')) {
      String id = data.link.queryParameters['id'] ?? '';
      Get.to(() => const DescriptionScreen());
      try {
        if (!Get.isRegistered<NoteController>()) {
          Get.put(NoteController());
        }
        final controller = Get.find<NoteController>();
        controller.getNoteDetail(id);
      } catch (e) {
        log('error in notes controller $e');
      }
    }
  }
}
