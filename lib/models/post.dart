import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final String datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.likes,
      required this.profImage});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "postId": postId,
        "likes": likes,
        "profImage": profImage,
        "description": description,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      datePublished: snapshot['datePublished'],
      profImage: snapshot['profImage'],
      description: snapshot['description'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
      postId: snapshot['postId'],
    );
  }
}
