import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_api_call/Custom/custom_button.dart';
import 'package:graphql_api_call/views/add_comment.dart';
import 'package:graphql_api_call/views/add_post.dart';
import 'package:graphql_api_call/views/comment_screen.dart';
import 'package:graphql_api_call/views/post_screen.dart';

class HomeScreen extends StatelessWidget {
  TextStyle style = TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Call using Dio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: GradientButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostScreen()),
                  );
                },
                gradient:
                    LinearGradient(colors: [Colors.teal, Colors.amber.shade400]),
                child: Text('See All Post',style: style,),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GradientButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommentScreen()),
                  );
                },
                gradient:
                    LinearGradient(colors: [Colors.teal, Colors.amber.shade400]),
                child: Text('See All Comment',style: style,),
                            ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GradientButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNewPost()),
                  );
                },
                gradient:
                    LinearGradient(colors: [Colors.teal, Colors.amber.shade400]),
                child: Text('Add New Post',style: style,),
                            ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GradientButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCommentToPost()),
                  );
                },
                gradient:
                    LinearGradient(colors: [Colors.teal, Colors.amber.shade400]),
                child: Text('Add New Comment',style: style,),
                            ),
              )
          ],
        ),
      ),
    );
  }
}
