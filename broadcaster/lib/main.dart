import 'package:flutter/material.dart';
import 'package:broadcaster/mainstuff.dart';


void main() { 
  runApp(Entry());
}



class Entry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Broadify',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:SafeArea(child: Broadcaster()));
  }
}

