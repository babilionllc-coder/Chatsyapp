import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../helper/all_imports.dart';

class TermsPageController extends GetxController {
  WebViewController? webController;
  String url =
      "https://aichatsy.com/web/terms-and-conditions/${(isLight) ? "li/" : ""}${Utils.languageCodeDefault}";
  // String url = "https://1d07-117-99-107-92.ngrok-free.app/terms-and-conditions/en";
  RxBool isHide = true.obs;
  @override
  void onInit() {
    // showLoader(true);

    EasyLoading.show();
    debugPrint("-=-==-  url $url");
    if (url != "") {
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
