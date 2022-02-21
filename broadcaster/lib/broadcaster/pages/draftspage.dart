import 'package:flutter/material.dart';

class Draftspage extends StatefulWidget {
  const Draftspage({Key key}) : super(key: key);
  
  @override
  State<Draftspage> createState() => _DraftspageState();
}

class _DraftspageState extends State<Draftspage> {
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
          Hero(tag: "drafts", child: Icon(Icons.drafts, color: Colors.purple, size: 30)),
          Text("DRAFTS CENTER", style: TextStyle(color: Colors.white),),
        ],
      ),),
    );
  }
}