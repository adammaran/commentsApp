import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_agency_test/app/database/comments_repository.dart';
import 'package:q_agency_test/app/models/comments/comments_response.dart';
import 'package:q_agency_test/app/services/comments_service.dart';

import '../../../models/comments/dynamic_response.dart';
import '../../../widgets/dialogs.dart';

enum HomePageState { loading, done, empty, paging }

class HomeController extends GetxController {
  ///Controls in what state is the screen.
  Rx<HomePageState> homePageState = HomePageState.loading.obs;
  bool isDeviceOnline = false;

  late ScrollController scrollController;

  late DynamicResponse<List<CommentsResponse>>? commentsResponse;
  late List<CommentsResponse> comments;
  int currentPageIndex = 1;

  @override
  void onInit() async {
    scrollController = ScrollController()..addListener(_loadMoreComments);
    await _setConnectivityWithListener();
    super.onInit();
  }

  @override
  void onReady() async {
    await getData();
    super.onReady();
  }

  Future<void> getData() async {
    ///Added delay for better presentation of progress indicator.
    await Future.delayed(const Duration(seconds: 1));
    if (isDeviceOnline) {
      currentPageIndex = 1;
      CommentsService().getCommentsByPage(1).then((value) {
        if (value.response!.isNotEmpty) {
          comments = value.response!;
          homePageState.value = HomePageState.done;
          _addNewDataToDatabase(comments);
        } else {
          homePageState.value = HomePageState.empty;
        }
      });
    } else {
      homePageState.value = HomePageState.loading;
      CommentsRepository().getComments().then((value) {
        if (value.response!.isNotEmpty) {
          comments = value.response!;
          homePageState.value = HomePageState.done;
        } else {
          homePageState.value = HomePageState.empty;
        }
      });
    }
  }

  ///Determines if the device is online. Sets [isDeviceOnline] to true or false depending on the state.
  ///Adds a listener that changes the data source(Api/Local Database) depending on the connectivity state
  _setConnectivityWithListener() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile &&
        connectivityResult == ConnectivityResult.wifi) {
      isDeviceOnline = true;
    } else {
      isDeviceOnline = false;
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        isDeviceOnline = true;
      } else {
        isDeviceOnline = false;
      }
      getData();
    });
  }

  ///Called when listView reaches the bottom.
  ///Loads 10 more comments and adds them to the existing comments list.
  _loadMoreComments() async {
    if (scrollController.position.atEdge &&
        scrollController.position.pixels != 0) {
      homePageState.value = HomePageState.paging;

      ///Added delay for better presentation of progress indicator.
      await Future.delayed(const Duration(seconds: 1));
      var newList =
          (await CommentsService().getCommentsByPage(++currentPageIndex));
      _addNewDataToDatabase(newList.response!);
      comments.addAll(newList.response!);
      homePageState.value = HomePageState.done;
    }
  }

  _addNewDataToDatabase(List<CommentsResponse> comments) {
    CommentsRepository()
      ..clearTableByName('comments')
      ..insertComments(comments);
  }

  ///Called when pull to refresh is triggered.
  onRefresh() {
    homePageState.value = HomePageState.empty;
    getData();
    return Future.delayed(Duration(seconds: 2));
  }

  ///Called when any of the listed cells are tapped.
  void openDialog(String leadingText, String text) {
    Dialogs.showOsDialog(leadingText, text);
  }

  @override
  void onClose() {}
}
