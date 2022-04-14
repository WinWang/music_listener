import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';

class MinePage extends BaseStatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Container(
    );
  }

  @override
  bool useLoadSir() => false;

  @override
  bool showTitleBar() => false;
}

class MineController extends BaseController {
  @override
  void loadNet() {}
}
