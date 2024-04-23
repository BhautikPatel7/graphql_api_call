class  UserPost {
  final int id;
  final int user_id;
  final String title;
  final String body;

  UserPost({required this.id, required this.user_id, required this.title, required this.body});
  
  factory UserPost.fromjson(Map<String, dynamic> json){
    return UserPost(id: json['id'], user_id: json['user_id'], title: json["title"], body: json["body"]);
  }
}