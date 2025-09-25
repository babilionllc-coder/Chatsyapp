/* import 'package:appvestor_billing_stats/appvestor_billing_stats.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AppVestoreController {
  Future<void> onInit() async {
    debugPrint("-=-=-AppVestoreController ");
    await AppvestorBillingStats.initialize(hasBilling: true);

    await AppvestorBillingStats.setAccountId(acId: "a1-5d541928-0a7f-4ffa-b0e5-cff62d0cf437");
    await AppvestorBillingStats.setAppId(apId: "b0-362dacba-ced6-4660-baa8-0f6da0a3756b");

    AppvestorBillingStats.firebaseEvents.listen((event) {
      debugPrint("AppvestorBillingStats event $event");
      if (event['payload'] != null) {
        FirebaseAnalytics.instance.logEvent(name: event['eventName'], parameters: event['payload']);
      }
    });
  }
}
 */
