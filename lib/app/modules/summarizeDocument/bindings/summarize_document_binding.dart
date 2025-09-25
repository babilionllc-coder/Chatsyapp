import 'package:get/get.dart';

import '../controllers/summarize_document_controller.dart';

class SummarizeDocumentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SummarizeDocumentController>(
      () => SummarizeDocumentController(),
    );
  }
}
