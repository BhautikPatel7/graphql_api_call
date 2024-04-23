import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_api_call/Constant/Api_Key.dart';
import 'package:graphql_api_call/model/comment_response_model.dart';
import 'package:graphql_api_call/model/post_response_model.dart';
import 'package:graphql_api_call/network/end_points.dart';
 
class AddCommentToPostWithDio extends StatefulWidget {
  @override
  AddCommentToPostWithDioState createState() => AddCommentToPostWithDioState();
}

class AddCommentToPostWithDioState extends State<AddCommentToPostWithDio> {
  //String to Store And Display Response
  String Commentidstr = '';
  String Postidstr = '';
  String namestr = '';
  String emailstr = '';
  String bodystr = '';
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController commentController = TextEditingController();


// Funcation to Add New Comment
  void addNewComment() async {
    String name = nameController.text;
    String email = emailController.text;
    String post_id = postController.text;
    String body = commentController.text;

    String emailRegex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp emailregExp = new RegExp(emailRegex);

    RegExp nameRegExp = RegExp(r"^[a-zA-Z]+$");

    // basic Client Side Validation

    if (name.isEmpty) {
      final snackBar = SnackBar(content: Text('Plese enter name'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (!(nameRegExp.hasMatch(name))) {
      final snackBar = SnackBar(content: Text('name Only Conatins character'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (email.isEmpty) {
      final snackBar = SnackBar(content: Text('Plese enter  Email'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (!(emailregExp.hasMatch(email))) {
      final snackBar = SnackBar(content: Text('Plese enter valid  Email'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (post_id.isEmpty) {
      final snackBar = SnackBar(content: Text('Plese enter id'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (body.isEmpty) {
      final snackBar = SnackBar(content: Text('Plese enter comment'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    try {
      Response response = await Dio().post(
          '${Endpoints.baseURL}${Endpoints.comments}',
          data: {               //Passing Parameter In The Body Of Post
            'name': name,
            'email': email,
            'post_id': post_id,
            'body': body
          },
          options: Options(
            headers: {"authorization": "Bearer ${ApiKey.API_KEY}"},   //Passing Authorization Token in Field Header
          ));
      UserComment newUser = UserComment.fromjson(response.data);
      Commentidstr = newUser.id.toString();
      Postidstr = newUser.post_id.toString();
      namestr = newUser.name.toString();
      bodystr = newUser.body.toString();
      emailstr = newUser.email.toString();

      nameController.clear();
      emailController.clear();
      postController.clear();
      commentController.clear();

      isLoading = true;
      setState(() {});  
    } on DioException catch (e) {
      print(e.response);
      if (e.response?.statusCode == 422) {
        final snackBar = SnackBar(content: Text('Enter Valid Post Id'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (e.response?.statusCode == 304) {
        final snackBar =
            SnackBar(content: Text('The resource was not modified.'));
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
        final snackBar = SnackBar(
            content: Text(
                'The authenticated user is not allowed to access the specified API'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 404) {
        print(' The requested resource does not exist.');
        final snackBar =
            SnackBar(content: Text(' The requested resource does not exist.'));
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

      if (e.response?.statusCode == 429) {
        final snackBar = SnackBar(content: Text('Too many requests'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.response?.statusCode == 500) {
        final snackBar = SnackBar(content: Text('Internal server error.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Comment To Post ')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.name,
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: postController,
              decoration: InputDecoration(labelText: 'Post_id'),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(labelText: 'Comment'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addNewComment,
              child: Text('Add Comment to Post'),
            ),
            Expanded(
                child: isLoading
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                            DataTable(
                              columns: [
                                DataColumn(
                                    label: Text(' Comment ID',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('Post  ID',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('Name',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('Email',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('Comment',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text(Commentidstr)),
                                  DataCell(Text(Postidstr)),
                                  DataCell(Text(namestr)),
                                  DataCell(Text(emailstr)),
                                  DataCell(Text(bodystr)),
                                ]),
                              ],
                            ),
                          ])
                    : Text(''))
          ],
        ),
      ),
    );
  }
}
