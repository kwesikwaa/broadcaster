import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class Groupspage extends StatefulWidget {
  const Groupspage({Key key}) : super(key: key);
  
  @override
  State<Groupspage> createState() => _GroupspageState();
}

class _GroupspageState extends State<Groupspage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ContactsClass().permit();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Hero(tag: "groups", child: Icon(Icons.contacts_outlined, color: Colors.purple, size: 30)),
          Text("GROUPS CENTER", style: TextStyle(color: Colors.white),),
          
          
        ],
      ),),
    );
  }
}