import 'package:dio/dio.dart';
import 'package:q_agency_test/app/constants/endpoints.dart';
import 'package:q_agency_test/app/models/comments/comments_response.dart';
import 'package:retrofit/http.dart';

part 'comments_api.g.dart';

@RestApi()
abstract class CommentsApi {
  factory CommentsApi(Dio dio, {String baseUrl}) = _CommentsApi;

  @GET(ApiEndpoints.comments)
  Future<List<CommentsResponse>> getCommentsByPage(@Query('_page') int pageNumber);
}
