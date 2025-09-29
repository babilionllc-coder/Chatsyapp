import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../helper/all_imports.dart';

class PrivacyPolicyController extends GetxController {
  WebViewController? webController;

  String url =
      "https://aichatsy.com/web/new-privacy-policy/${(isLight) ? "li/" : ""}${Utils.languageCodeDefault}";
  RxBool isHide = true.obs;

  @override
  void onInit() {
    EasyLoading.show();
    if (kDebugMode) {
      debugPrint("-=-==-  url $url");
    }
    if (url != "") {
      printAction("ewkjhbfvdsidhsvjldfsfv");
      webController =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(url));

      webController!.setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            // showLoader(false);
            isHide.value = false;
            printAction("${isHide.value}${webController != null}");
            EasyLoading.dismiss();
          },
        ),
      );
    }
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    EasyLoading.dismiss();

    super.onClose();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();

    super.dispose();
  }
}
