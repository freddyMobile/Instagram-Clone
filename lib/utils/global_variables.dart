import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/screens/feed_screen.dart';
import 'package:flutter_instagram_clone/screens/profile_screen.dart';
import 'package:flutter_instagram_clone/screens/search_screen.dart';
import '../screens/add_post_screen.dart';

const webScreenSzie = 600;

var homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(child: Text('notif')),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
