import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_api_call/network/add_post_dio.dart';
import 'package:graphql_api_call/model/post_response_model.dart';



class AddNewPost extends StatelessWidget {
  // void setoFInterceptor() {
  @override
  Widget build(BuildContext context) {
    return CreateANewPostWithDio();
  }
}
