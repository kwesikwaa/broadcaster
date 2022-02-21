import 'package:flutter/material.dart';

class Historypage extends StatefulWidget {
  const Historypage({Key key}) : super(key: key);
  
  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
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
          Hero(tag: "history", child: Icon(Icons.history_outlined, color: Colors.purple, size: 30)),
          Text("HISTORY CENTER", style: TextStyle(color: Colors.white),),
        ],
      ),),
    );
  }
}