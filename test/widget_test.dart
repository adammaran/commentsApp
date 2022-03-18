import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:q_agency_test/app/database/comments_repository.dart';
import 'package:q_agency_test/app/models/comments/comments_response.dart';
import 'package:q_agency_test/app/models/comments/dynamic_response.dart';
import 'package:q_agency_test/app/services/comments_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///Tests whether the api call returns 10 elements when calling a page
  test('First page request test', () async {
    int expectedResponse = 10;
    DynamicResponse<List<CommentsResponse>> response =
        await CommentsService().getCommentsByPage(1);
    expect(response.response!.length, expectedResponse);
  });

  test('Second page request test', () async {
    int expectedResponse = 10;
    DynamicResponse<List<CommentsResponse>> response =
        await CommentsService().getCommentsByPage(2);
    expect(response.response!.length, expectedResponse);
  });
}
