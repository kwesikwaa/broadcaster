// ignore_for_file: prefer_const_constructors

import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:broadcaster/broadcaster/newbroadcasterui.dart';
import 'package:broadcaster/broadcaster/pages/history.dart';
import 'package:broadcaster/broadcaster/pages/messagepage.dart';
import 'package:broadcaster/rnd/newset.dart';
import 'package:broadcaster/toyshop/pages/homestore.dart';
// import 'package:broadcaster/screens/pagscrollerNew.dart';
import 'package:flutter/material.dart';
import 'package:broadcaster/mainstuff.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'rnd/pagscrollerNew.dart';



void main() async { 

  // WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive
  //   ..registerAdapter(DraftAdapter())
  //   ..registerAdapter(HistoryAdapter())
  //   ..registerAdapter(BroadcastContactAdapter())
  //   ..registerAdapter(PhoneContactAdapter())
  //   ..registerAdapter(BroadcastGroupAdapter());
  
  // await Hive.openBox<Draft>('drafts');
  // await Hive.openBox<Draft>('drafts');
  // await Hive.openBox<History>('history');
  // await Hive.openBox<BroadcastGroup>('broadcastgroups');
  
  // runApp(Entry());

  //toy shop

  runApp(ProviderScope(child: Entry()));

}



class Entry extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {
    ContactsClass().permit();
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
          // BroadcastUI()
          Homestore()
          // ToyShop()
        ));
  }
}

