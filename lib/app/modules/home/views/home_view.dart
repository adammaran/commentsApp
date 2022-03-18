import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:q_agency_test/app/constants/build_config.dart';

// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:q_agency_test/app/constants/strings.dart';
import 'package:q_agency_test/app/constants/theme.dart';
import 'package:q_agency_test/app/models/comments/comments_response.dart';
import 'package:q_agency_test/app/widgets/divires.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BuildConfig.homeTitle),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: Stack(
          children: [
            Container(
              height: 300,
              width: Get.width,
            ),
            Obx(() => controller.homePageState.value == HomePageState.loading
                ? _buildLoadingBody()
                : _buildBody()),
          ],
        ),
      ),
    );
  }

  _buildLoadingBody() => Center(
        child: CircularProgressIndicator(),
      );

  _buildBody() {
    return Column(children: [
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            controller: controller.scrollController,
            itemCount: controller.comments.length,
            itemBuilder: (_, index) => _buildListRow(index)),
      ),
      Obx(() => controller.homePageState.value == HomePageState.paging
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            )
          : Container())
    ]);
  }

  _buildListRow(int index) {
    CommentsResponse comment = controller.comments.elementAt(index);
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          Container(
            height: 50,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRowElement(
                    '${AppStrings.postId}: ', comment.postId.toString()),
                VerticalDividerWidget.showDefault(),
                _buildRowElement('${AppStrings.iD}: ', comment.id.toString()),
                VerticalDividerWidget.showDefault(),
                Expanded(
                    child: _buildRowElement(
                        '${AppStrings.email}: ', comment.email!)),
              ],
            ),
          ),
          HorizontalDivider.showDefault(),
          _buildRowElement('${AppStrings.name}: ', comment.name!),
          HorizontalDivider.showDefault(),
          _buildRowElement('${AppStrings.body}: ', comment.body!)
        ],
      ),
    );
  }

  _buildRowElement(String leadingTitle, String text) {
    return GestureDetector(
      onTap: () {
        controller.openDialog(leadingTitle, text);
      },
      child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(text: leadingTitle, style: ThemeStyle.titleText),
              TextSpan(text: text, style: ThemeStyle.bodyText)
            ]),
          )),
    );
  }
}
