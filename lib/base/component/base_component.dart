import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/widget/load_state_widget.dart';
import 'package:music/widget/loading_widget.dart';

///定义View组件--页面内某个模块Widget
// ignore: must_be_immutable
abstract class BaseComponent<T extends BaseController> extends GetView<T> {
  String? componentTag;

  BaseComponent({Key? key, this.componentTag}) : super(key: key);

  @override
  String? get tag => componentTag;

  @override
  Widget build(BuildContext context) {
    if (useLoadSir()) {
      return controller.obx((state) => buildContent(context),
          onLoading: Center(
            child: LoadingWidget(),
          ),
          onError: (error) => createErroWidget(controller, error),
          onEmpty: createEmptyWidget(controller));
    } else {
      return buildContent(context);
    }
  }

  ///showSuccess展示成功的布局
  Widget buildContent(BuildContext context);

  bool useLoadSir() => true;
}
