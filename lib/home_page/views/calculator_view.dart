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
                () => _showHistoryDialog(context, Get.find<HomeController>()),
          ),
        ],
      ),

      body: GetBuilder<HomeController>(
        builder:
            (controller) => Column(
              children: [
                SizedBox(height: 35),
                _buildDisplay(),
                _buildToggleButton(),
                if (controller.isAdvanced) _buildAdvancedButtons(),
                Expanded(child: _buildBasicButtons()),
              ],
            ),
      ),
    );
  }

  Widget _buildDisplay() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          alignment: Alignment.bottomRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                controller.input,
                style: TextStyle(fontSize: 24, color: Colors.grey[700]),
              ),
              SizedBox(height: 8),
              Text(
                controller.result,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleButton() {
    return Row(
      children: [
        Expanded(
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.advancedButtonsOk.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    final btn = controller.advancedButtonsOk[index];
                    return _advancedButtons(
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEBF0FD),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
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

  Widget _buildAdvancedButtons() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.advancedButtons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              final btn = controller.advancedButtons[index];
              return _advancedButtons(btn, isAdvanced: true, index: index);
            },
          ),
        );
      },
    );
  }

  Widget _advancedButtons(
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
            height: 100,
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),

            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBasicButtons() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return GridView.builder(
          padding: EdgeInsets.all(8),
          itemCount: controller.basicButtons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.4,
          ),
          itemBuilder: (context, index) {
            final btn = controller.basicButtons[index];
            return _buildButton(btn, index);
          },
        );
      },
    );
  }

  Widget _buildButton(String text, index) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => controller.handleButtonPress(text),
          child: Container(
            alignment: Alignment.center,
            height: 180,
            width: 220,
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
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),

            child: Text(
              // index.toString(),
              text,
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
  // }Widget _buildButton(String text, {bool isAdvanced = false}) {
  //   return ElevatedButton(
  //     onPressed: () => _handleButtonPress(text),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: isAdvanced ? Colors.grey[200] : Colors.grey[100],
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     ),
  //     child: Text(text, style: TextStyle(fontSize: 18, color: Colors.black87)),
  //   );
  // }

  void _showHistoryDialog(BuildContext context, controller) {
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
