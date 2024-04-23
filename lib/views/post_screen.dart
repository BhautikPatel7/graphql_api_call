import 'package:flutter/material.dart';
import 'package:graphql_api_call/network/dio_client_comment.dart';
import 'package:graphql_api_call/network/dio_client_post.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return DioClientPost();
  }
  
}