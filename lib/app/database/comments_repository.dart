import 'package:flutter/cupertino.dart';
import 'package:q_agency_test/app/database/database_helper.dart';
import 'package:q_agency_test/app/models/comments/comments_response.dart';
import 'package:q_agency_test/app/models/comments/dynamic_response.dart';
import 'package:sqflite/sqflite.dart';

import '../models/comments/confirmation_response.dart';

class CommentsRepository {
  Future<ConfirmationResponse> insertComments(
      List<CommentsResponse> comments) async {
    try {
      Database db = await DatabaseHelper().database;
      for (var element in comments) {
        db.insert('comments', element.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      debugPrint('Added comments successfully to local database');
      return ConfirmationResponse('200', 'Comments added successfully');
    } catch (e) {
      debugPrint(e.toString());
      return ConfirmationResponse('400', e.toString());
    }
  }

  Future<DynamicResponse<List<CommentsResponse>>> getComments() async {
    try {
      Database db = await DatabaseHelper().database;
      List<Map<String, dynamic>> response = await db.query('comments');
      return DynamicResponse('200', 'success',
          response: List.generate(response.length,
              (index) => CommentsResponse.fromJson(response.elementAt(index))));
    } catch (e) {
      debugPrint(e.toString());
      return DynamicResponse('400', e.toString());
    }
  }

  Future<ConfirmationResponse> clearTableByName(String tableName) async {
    try {
      Database db = await DatabaseHelper().database;
      db.rawDelete('DELETE FROM $tableName');
      debugPrint('Successfully cleared data from table $tableName');
      return ConfirmationResponse(
          '200', 'Successfully cleared data from table $tableName');
    } catch (e) {
      debugPrint(e.toString());
      return ConfirmationResponse('400', e.toString());
    }
  }
}
