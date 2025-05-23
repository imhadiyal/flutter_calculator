import 'package:calling/home_page/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_sharp),
            onPressed:
                () => showHistoryDialog(context, Get.find<HomeController>()),
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder:
            (controller) => Column(
              children: [
                SizedBox(height: Get.height * 0.035),
                outputDisplay(),
                toggleButton(),
                if (controller.isAdvanced) advancedButtons(),
                Expanded(child: basicButtons()),
              ],
            ),
      ),
    );
  }

  Widget outputDisplay() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04,
            vertical: Get.height * 0.03,
          ),
          alignment: Alignment.bottomRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                controller.input,
                style: TextStyle(
                  fontSize: Get.height * 0.025,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Text(
                controller.result,
                style: TextStyle(
                  fontSize: Get.height * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget toggleButton() {
    return Row(
      children: [
        Expanded(
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.advancedButtonsTop.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: Get.height * 0.01,
                    crossAxisSpacing: Get.width * 0.02,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    final btn = controller.advancedButtonsTop[index];
                    return showAdvancedButtons(
                      btn,
                      isAdvanced: true,
                      index: index,
                    );
                  },
                ),
              );
            },
          ),
        ),
        GetBuilder<HomeController>(
          builder: (controller) {
            return GestureDetector(
              onTap: controller.toggleAdvanced,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02,
                  vertical: Get.height * 0.01,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEBF0FD),
                    borderRadius: BorderRadius.circular(Get.width * 0.015),
                  ),
                  child: Icon(
                    controller.isAdvanced
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget advancedButtons() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.advancedButtons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: Get.height * 0.01,
              crossAxisSpacing: Get.width * 0.02,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              final btn = controller.advancedButtons[index];
              return showAdvancedButtons(btn, isAdvanced: true, index: index);
            },
          ),
        );
      },
    );
  }

  Widget showAdvancedButtons(
    String text, {
    bool isAdvanced = false,
    required index,
  }) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => controller.handleButtonPress(text),
          child: Container(
            alignment: Alignment.center,
            height: Get.height * 0.08,
            width: Get.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Get.width * 0.05),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: Get.height * 0.022,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget basicButtons() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return GridView.builder(
          padding: EdgeInsets.all(Get.width * 0.02),
          itemCount: controller.basicButtons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: Get.height * 0.015,
            crossAxisSpacing: Get.width * 0.02,
            childAspectRatio: 1.4,
          ),
          itemBuilder: (context, index) {
            final btn = controller.basicButtons[index];
            return showButton(btn, index);
          },
        );
      },
    );
  }

  Widget showButton(String text, index) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => controller.handleButtonPress(text),
          child: Container(
            alignment: Alignment.center,
            height: Get.height * 0.1,
            width: Get.width * 0.2,
            decoration: BoxDecoration(
              color:
                  index == 0 ||
                          index == 1 ||
                          index == 2 ||
                          index == 3 ||
                          index == 7 ||
                          index == 11 ||
                          index == 15 ||
                          index == 19
                      ? Color(0xFFF2F2F2)
                      : Color(0xFFEBF0FD),
              borderRadius: BorderRadius.circular(Get.width * 0.05),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: Get.height * 0.022,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  void showHistoryDialog(BuildContext context, controller) {
    final history = controller.history;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('History'),
          content: SizedBox(
            width: double.maxFinite,
            child:
                history.isEmpty
                    ? Text('No history yet.')
                    : ListView.builder(
                      shrinkWrap: true,
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(history[index]));
                      },
                    ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.clearHistory();
                Navigator.of(ctx).pop();
              },
              child: Text('Clear History'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
