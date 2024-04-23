import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_api_call/Constant/Api_Key.dart';
import 'package:graphql_api_call/model/post_response_model.dart';
import 'package:graphql_api_call/network/end_points.dart';



class CreateANewPostWithDio extends StatefulWidget {
  @override
  CreateANewPostWithDioState createState() => CreateANewPostWithDioState();
}

class CreateANewPostWithDioState extends State<CreateANewPostWithDio> {
  String postidstr = '';
  String useridstr = '';
  String titlestr = '';
  String bodystr = '';
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userController = TextEditingController();

  void addNewPost() async {
    String title = nameController.text;
    String body = emailController.text;
    String user_id = userController.text;

    if (title.isEmpty) {
        final snackBar =
            SnackBar(content: Text('Plese enter Title'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
    }
      if (body.isEmpty) {
        final snackBar =
            SnackBar(content: Text('Plese enter Post Detail'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
    }
    try {
      Response response =
          await Dio().post('${Endpoints.baseURL}${Endpoints.posts}',
              data: {'title': title, 'body': body, 'user_id': user_id},
              options: Options(
                headers: {"authorization": "Bearer ${ApiKey.API_KEY}"},
              ));
      UserPost newUser = UserPost.fromjson(response.data);
      postidstr = newUser.id.toString();
      useridstr = newUser.user_id.toString();
      titlestr = newUser.title.toString();
      bodystr = newUser.body.toString();
      nameController.clear();
      emailController.clear();
      userController.clear();
      isLoading = true;
      setState(() {});
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final snackBar = SnackBar(content: Text('Enter Valid User Id'));
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
      appBar: AppBar(title: Text('Add New Post')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Post'),
            ),
            TextField(
              controller: userController,
               keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'User_id'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addNewPost,
              child: Text('Add New Post'),
            ),
            Expanded(
              child: isLoading ? ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[    
              DataTable(  
                columns: [  
                  DataColumn(label: Text(  
                      ' Post ID',  
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                  )),  
                  DataColumn(label: Text(  
                      'user ID',  
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                  )),  
                  DataColumn(label: Text(  
                      'Title',  
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                  )), 
                  DataColumn(label: Text(  
                      'Post',  
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                  )),  
                ],  
                rows: [  
                  DataRow(cells: [  
                    DataCell(Text(postidstr)),  
                    DataCell(Text(useridstr)),  
                    DataCell(Text(titlestr)),  
                    DataCell(Text(bodystr)),  
                  ]),  
                ],  
              ),  
                        ])

            : Text('')
            )
          ],
        ),
      ),
    );
  }
}
