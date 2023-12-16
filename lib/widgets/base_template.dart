import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/constants.dart';
import 'package:todo/controllers/TodoController.dart';
import 'package:todo/controllers/baseController.dart';
import 'package:todo/widgets/Insets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BaseTemplate extends StatelessWidget {
  BaseTemplate({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.enableBack = false,
  });

  final Widget child;
  final Widget? floatingActionButton;
  final bool enableBack;
  final BaseController baseController = Get.find();
  final TodoController todoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: const Size(double.maxFinite, 70),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Insets.spacingTiny,
                      vertical: Insets.spacingStandard),
                  color: Colors.white,
                  child: Row(children: [
                    enableBack
                        ? GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: IconSizes.iconStandard,
                              color: Colors.black87,
                            ),
                          )
                        : const Icon(
                            Icons.menu_rounded,
                            size: IconSizes.iconStandard,
                            color: Colors.black87,
                          ),
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constants.greenLight,
                          border:
                              Border.all(color: Constants.grey_20, width: 1.2)),
                      child: const Icon(
                        Icons.android,
                        size: IconSizes.iconStandard,
                        color: Colors.white,
                      ),
                    ),
                  ]),
                ),
              ),
              floatingActionButton: floatingActionButton,
              body: RefreshIndicator(
                backgroundColor: Colors.white,
                color: Constants.orange,
                onRefresh: () async=> await todoController.fetchTasks(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Insets.spacingSmall,
                        vertical: Insets.spacingSmall),
                    child: child,
                  ),
                ),
              ),
            ),
            if (baseController.isLoading.isTrue)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: SpinKitWave(
                    color: Constants.orange,
                    size: 50.0,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
