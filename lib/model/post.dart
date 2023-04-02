class Post {
  String description;
  List likes;
  String postId;
  String uid;
  String postUrl;
  DateTime datePosted;
  String username;
  String type;
  String profilePic;
  String color;

  Post(
      {required this.description,
      required this.likes,
      required this.postId,
      required this.uid,
      required this.postUrl,
      required this.datePosted,
      required this.username,
      required this.type,
      required this.profilePic,
      required this.color});

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'likes': likes,
      'postId': postId,
      'uid': uid,
      'postUrl': postUrl,
      'datePosted': datePosted,
      'username': username,
      'type': type,
      'profilePic': profilePic,
      'color': color,
    };
  }
}
