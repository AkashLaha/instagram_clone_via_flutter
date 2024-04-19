import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class CommentSccreen extends StatefulWidget {
  const CommentSccreen({super.key});

  @override
  State<CommentSccreen> createState() => _CommentSccreenState();
}

class _CommentSccreenState extends State<CommentSccreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
    );
  }
}
