import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../service/core/exception.dart';

mixin PaginationHelper {
  late var scrollController = ScrollController()..addListener(_scrollListener);

  var end = false.obs;
  var loading = false.obs;

  final apiState = Rx<ApiState>(InitialState());

  final cancelToken = CancelToken();

  void _scrollListener() {
    if (end.value ||
        apiState.value is LoadingState ||
        scrollController.offset < scrollController.position.maxScrollExtent - 70) {
      return;
    }
    scrollListener();
  }

  void scrollListener();

  void removeListenerAndDispose() {
    if (apiState.isLoading) {
      cancelToken.cancel();
    }
    scrollController
      ..removeListener(_scrollListener)
      ..dispose();
  }
}
