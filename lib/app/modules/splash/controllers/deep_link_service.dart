import 'dart:async';
import 'dart:convert';

import 'package:chatsy/app/modules/OfferScreen/views/offer_screen_view.dart';
import 'package:chatsy/app/modules/SpecialOfferScreen/views/special_offer_screen_view.dart';
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';

import '/extension.dart';
import '../../../helper/Global.dart';
import '../../../helper/constants.dart';
import '../../../helper/utils.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';

class DeepLinkService extends GetxService {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<dynamic>? _linkSubscription;
  final RxString _currentDeepLink = ''.obs;

  goToOfferPageWithCondition({required String? condition}) {
    if (getStorageData.containKey(getStorageData.loginData)) {
      if (condition == Constants.offer25) {
        if (Get.isRegistered<BottomNavigationController>()) {
          SpecialOfferScreenView.route()?.then((value) {
            if (value == "plan_purchase") {
              Get.put(BottomNavigationController()).getUserProfileAPI(isLoading: true);
            }
          });
        } else {
          Global.offerType = condition;
        }
      } else if (condition == Constants.offer35) {
        if (Get.isRegistered<BottomNavigationController>()) {
          OfferScreenView.route()?.then((value) {
            if (value == "plan_purchase") {
              Get.put(BottomNavigationController()).getUserProfileAPI(isLoading: true);
            }
          });
        } else {
          Global.offerType = condition;
        }
      }
    } else {
      Utils().showToast(message: 'Please login your account');
    }
  }

  Future<void> initDeepLinking() async {
    try {
      // Handle the initial deep link when the app is launched
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        ('>> 1 >> Initial link: $initialLink').log;
        _handleDeepLink(initialLink.toString());
      }
    } catch (e) {
      ('>> 1 >> Error handling initial link: $e').log;
    }

    // Listen for incoming deep links
    _linkSubscription = _appLinks.stringLinkStream.listen(
      (String? link) {
        if (link != null) {
          ('>> 2 >> Stream deep link: $link').log;

          _handleDeepLink(link);
        }
      },
      onError: (err) {
        ('>> 2 >> Error in deep link stream: $err').log;
      },
    );
  }

  // Handle deep links and navigate based on the URL

  void _handleDeepLink(String link) {
    _currentDeepLink.value = link;

    ('>> 3 >> Received deep link: $link').log;

    if (link.contains("share/")) {
      String? argumentValue = utf8.fuse(base64).decode(link.split('share/').last);
      printAction('argument first--------<<<<----->>>>>$argumentValue');
      goToOfferPageWithCondition(condition: argumentValue);
    }
  }

  @override
  void onClose() {
    _linkSubscription?.cancel();
    super.onClose();
  }
}
