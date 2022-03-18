import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:q_agency_test/app/api/api_client.dart';
import 'package:q_agency_test/app/api/comments/comments_api.dart';
import 'package:q_agency_test/app/constants/build_config.dart';
import 'package:q_agency_test/app/constants/endpoints.dart';
import 'package:q_agency_test/app/models/comments/comments_response.dart';
import 'package:q_agency_test/app/models/comments/dynamic_response.dart';

class CommentsService extends GetxService {
  final ApiClient _apiClient = ApiClient();

  late final CommentsApi _commentsApi =
      CommentsApi(_apiClient.dio, baseUrl: BuildConfig.baseUrl);

  Future<DynamicResponse<List<CommentsResponse>>> getCommentsByPage(
      int pageNumber) async {
    try {
      List<CommentsResponse> response =
          await _commentsApi.getCommentsByPage(pageNumber);
      return DynamicResponse('200', 'success', response: response);
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.toString());
        return DynamicResponse(e.response!.statusCode.toString(), e.message);
      } else {
        debugPrint(e.toString());
        return DynamicResponse('400', e.toString());
      }
    }
  }
}
