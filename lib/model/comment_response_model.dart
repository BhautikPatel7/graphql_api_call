class  UserComment {
  final int id;
  final int post_id;
  final String name;
  final String email;
  final String body;

  UserComment({required this.id, required this.post_id, required this.name,required this.email,  required this.body});
  
  factory UserComment.fromjson(Map<String, dynamic> json){
    return UserComment(id: json['id'], post_id: json['post_id'], name: json["name"],email: json["email"], body: json["body"]);
  }
}