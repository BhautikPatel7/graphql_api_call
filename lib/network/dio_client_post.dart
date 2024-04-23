import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_api_call/model/post_response_model.dart';
import 'package:graphql_api_call/network/end_points.dart';

class DioClientPost extends StatefulWidget {
  @override
  State<DioClientPost> createState() => _DioClientState();
}

class _DioClientState extends State<DioClientPost> {
  List<UserPost> userpost = [];
  bool isLoading = true;
  @override
  void initState() {
    getAllPostData();
    super.initState();
  }

  Future<void> getAllPostData() async {
    try {
      final dio = Dio();
      Response response =
          await dio.get('${Endpoints.baseURL}${Endpoints.posts}');
      List<dynamic> jsonData = response.data;
      userpost = jsonData.map((user) => UserPost.fromjson(user)).toList();
      isLoading = false;
      // print(response.statusCode);
      setState(() {});
    } on DioException catch (e) {
      if (e.response?.statusCode == 304) {
        final snackBar = SnackBar(content: Text('The resource was not modified.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // print('The resource was not modified. You can use the cached version.');
      
      }
      if (e.response?.statusCode == 400) {
        final snackBar = SnackBar(content: Text('Bad request.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // print(
        //     'Bad request. This could be caused by various actions by the user, such as providing invalid JSON data in the request body etc.');
      }
      if (e.response?.statusCode == 401) {
        // print('Authentication failed.');
        final snackBar = SnackBar(content: Text('Authentication failed.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 403) {
        // print(
        //     ' The authenticated user is not allowed to access the specified API endpoint.');
            final snackBar = SnackBar(content: Text('The authenticated user is not allowed to access the specified API'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 404) {
        print(' The requested resource does not exist.');
          final snackBar = SnackBar(content: Text(' The requested resource does not exist.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 405) {
        // print(
        //     'Method not allowed. Please check the Allow header for the allowed HTTP methods.');
            final snackBar = SnackBar(content: Text('Method not allowed.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 415) {
        // print(
        //     ' Unsupported media type. The requested content type or version number is invalid.');
            final snackBar = SnackBar(content: Text('Unsupported media type.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 422) {
        // print(
        //     'Data validation failed (in response to a POST request, for example). Please check the response body for detailed error messages.');
            final snackBar = SnackBar(content: Text('Data validation failed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 429) {
        // print(
        //     ' Too many requests. The request was rejected due to rate limiting.');
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
    getAllPostData();
    return Scaffold(
        appBar: AppBar(
          title: Text('All User Post'),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                                DataColumn(label: Text('User Id')),
                                DataColumn(label: Text('Title')),
                                DataColumn(label: Text('Post')),
                              ],
                              rows: userpost
                                  .map((e) => DataRow(cells: [
                                        DataCell(Text('${e.id}')),
                                        DataCell(Text('${e.user_id}')),
                                        DataCell(Text(e.title)),
                                        DataCell(Text(e.body)),
                                      ]))
                                  .toList()),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
