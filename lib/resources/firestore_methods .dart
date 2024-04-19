import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/models/posts.dart';
import 'package:insta_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postid = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postid: postid,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);
      _firestore.collection('posts').doc(postid).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postid, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
