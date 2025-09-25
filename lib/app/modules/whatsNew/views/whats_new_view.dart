import 'package:chatsy/app/common_widget/common_screen.dart';

import '../../../helper/all_imports.dart';
import '../controllers/whats_new_controller.dart';

class WhatsNewView extends GetView<WhatsNewController> {
  const WhatsNewView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhatsNewController>(
      init: WhatsNewController(),
      builder: (controller) {
        return CommonScreen(leading: SizedBox(), title: "", body: SizedBox(), toolbarHeight: 0);
      },
    );
  }
}
