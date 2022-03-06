// ignore_for_file: prefer_const_constructors

import 'package:broadcaster/broadcaster/newbroadcasterui.dart';
import 'package:broadcaster/broadcaster/pages/history.dart';
import 'package:broadcaster/broadcaster/pages/messagepage.dart';
import 'package:broadcaster/rnd/newset.dart';
// import 'package:broadcaster/screens/pagscrollerNew.dart';
import 'package:flutter/material.dart';
import 'package:broadcaster/mainstuff.dart';

import 'rnd/pagscrollerNew.dart';


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
      home:SafeArea(
        child:
        //two seperate apps and since this isnt production app
        //why not
          // Historypage()
          // Messagepage()
          BroadcastUI()
          // ToyShop()
        ));
  }
}

