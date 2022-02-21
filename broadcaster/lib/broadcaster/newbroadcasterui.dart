import 'dart:ui';

import 'package:broadcaster/broadcaster/pages/draftspage.dart';
import 'package:broadcaster/broadcaster/pages/groupspage.dart';
import 'package:broadcaster/broadcaster/pages/history.dart';
import 'package:broadcaster/broadcaster/pages/messagepage.dart';
import 'package:flutter/material.dart';

class BroadcastUI extends StatelessWidget {
  const BroadcastUI({Key key}) : super(key: key);

  final _focus = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/aa.png'),
                fit: BoxFit.cover )),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
              child: Container(color: Colors.white70.withOpacity(0.91),),),
          ),
          Align(
            alignment: const Alignment(0,-0.6),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceInOut,
              scale: _focus?1:0.8,
              alignment: Alignment.bottomCenter,
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceInOut,
                turns: _focus?-0.4:0,
                alignment: Alignment.bottomCenter,
                child: Image(
                  image: const AssetImage('assets/images/aaa2.png'),
                  width: size.width*.6,
                  // height: size.width*.5,
                ),
              ),
            ),
          ),
          
          Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.4,
                widthFactor: 0.5,
                child: Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(5),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1,
                    children: List.generate(4, (index) =>Transform.translate(
                      offset: Offset(index==3?5:0,index==3?5:0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: (){
                            _pushto(context, index);
                          },
                          splashColor: Colors.red,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [BoxShadow(color: Colors.black12,offset:Offset(0.1,3), blurRadius: 5,spreadRadius: 2)]
                            ),
                            child: icony(index),
                          ),
                        ),
                      ),
                    )),
                    ),
                ),
              ),
            ),
          const Align(
            alignment: Alignment(0,0.9),
            child: Text('Palmwine Studio', style: TextStyle(color: Colors.black45),),
          ),
        ],
      ),
    );
  }
}

icony(index){
  if(index == 0){
    return const Hero(tag:"groups",child: Icon(Icons.contacts_outlined, color: Colors.orange, size: 30,));
  }
  else if(index == 1){
    return const Hero(tag:"drafts",child: Icon(Icons.drafts_outlined, color: Colors.brown, size: 30));
  }
  else if(index == 2){
    return const Hero(tag:"history",child: Icon(Icons.history_outlined, color: Colors.grey, size: 30));
  }
  else if(index == 3){
    return const Hero(tag:"message",child: Icon(Icons.message, color: Colors.green, size: 30));
  }
  // return Container();
}

//refactor these into routes instead

_pushto(BuildContext context, int index){
  if(index==0){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Groupspage()));
  }
  if(index==1){Navigator.push(context, MaterialPageRoute(builder: (context)=>Draftspage()));}
  if(index==2){Navigator.push(context, MaterialPageRoute(builder: (context)=>Historypage()));}
  if(index==3){Navigator.push(context, MaterialPageRoute(builder: (context)=>Messagepage()));}
}