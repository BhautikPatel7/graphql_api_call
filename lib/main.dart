import 'package:flutter/material.dart';
import 'package:graphql_api_call/network/add_comment_dio.dart';
import 'package:graphql_api_call/network/add_post_dio.dart';
import 'package:graphql_api_call/network/dio_client_comment.dart';
import 'package:graphql_api_call/network/dio_client_post.dart';
import 'package:graphql_api_call/views/add_comment.dart';
import 'package:graphql_api_call/views/add_post.dart';
import 'package:graphql_api_call/views/comment_screen.dart';
import 'package:graphql_api_call/views/home_screen.dart';
import 'package:graphql_api_call/views/post_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQl Api Call',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    home: HomeScreen(),
    );
  }
}


