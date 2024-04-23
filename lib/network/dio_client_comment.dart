import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_api_call/model/comment_response_model.dart';
import 'package:graphql_api_call/model/post_response_model.dart';
import 'package:graphql_api_call/network/end_points.dart';

class DioClientComment extends StatefulWidget {
  @override
  State<DioClientComment> createState() => _DioClientState();
}

class _DioClientState extends State<DioClientComment> {
  List<UserComment> userComment = [];
  bool isLoading = true;
  @override
  void initState() {
    getAllCommentData();
    super.initState();
  }

  Future<void> getAllCommentData() async {
    try {
        final dio = Dio();
  Response response = await dio.get('${Endpoints.baseURL}${Endpoints.comments}');
  List<dynamic> jsonData = response.data;
  userComment = jsonData.map((user) => UserComment.fromjson(user)).toList();
  isLoading = false;
  setState(() {});
    } on DioException catch (e) {
       if (e.response?.statusCode == 304) {
        final snackBar = SnackBar(content: Text('The resource was not modified.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);   
      }
      if (e.response?.statusCode == 400) {
        final snackBar = SnackBar(content: Text('Bad request.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 401) {
        final snackBar = SnackBar(content: Text('Authentication failed.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 403) {
            final snackBar = SnackBar(content: Text('The authenticated user is not allowed to access the specified API'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 404) {
        print(' The requested resource does not exist.');
          final snackBar = SnackBar(content: Text(' The requested resource does not exist.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 405) {
            final snackBar = SnackBar(content: Text('Method not allowed.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 415) {
            final snackBar = SnackBar(content: Text('Unsupported media type.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 422) {
            final snackBar = SnackBar(content: Text('Data validation failed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 429) {
            final snackBar = SnackBar(content: Text('Too many requests'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 500) {
           final snackBar = SnackBar(content: Text('Internal server error.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
       isLoading = false;
    }
}

  @override
  Widget build(BuildContext context) {
    getAllCommentData();
    return Scaffold(
      appBar: AppBar(
        title: Text('All User Comment'),
      ),
      body: isLoading
      ? Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                child: FittedBox(
                  child: DataTable(
                    sortColumnIndex: 1,
                    showCheckboxColumn: false,
                    border: TableBorder.all(width: 1.0),
                    columns: [
                      DataColumn(label: Text('Id')),
                      DataColumn(label: Text('Post Id')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Comment')),
                    ],
                     rows: userComment.map((e) => DataRow(cells: [
                      DataCell(Text('${e.id}')),
                      DataCell(Text('${e.post_id}')),
                      DataCell(Text(e.email)),
                      DataCell(Text(e.name)),
                      DataCell(Text(e.body)),
                     ])).toList()
                     ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}


