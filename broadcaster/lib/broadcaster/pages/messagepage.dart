import 'dart:js';

import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:flutter/material.dart';

class Messagepage extends StatefulWidget {
  const Messagepage({Key key}) : super(key: key);
  
  @override
  State<Messagepage> createState() => _MessagepageState();
}


class _MessagepageState extends State<Messagepage> {
  var msgfield = TextEditingController();
  final  _scrontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrontroller.addListener(() { });
  }

  @override
  void dispose() {
    super.dispose();
    msgfield.dispose();
    _scrontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      
      body: Container(color: Colors.white,
      padding: const EdgeInsets.all(10),
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Hero(tag: "message", child: Icon(Icons.message, color: Colors.cyan, size: 100)),
            //put it in a limitedbox?
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration:BoxDecoration(border: Border.all(color: Colors.cyan),borderRadius: BorderRadius.circular(3)),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: List.generate(broadcastgroups.length, (index) => 
                      OutlinedButton(
                        onPressed: (){
                          setState(() {
                            broadcastgroups[index].selected = !broadcastgroups[index].selected;  
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.cyan.withOpacity(broadcastgroups[index].selected?1:0),
                          side: const BorderSide(width: 1, color: Colors.cyan)),
                        child: Text(broadcastgroups[index].name,
                          style: TextStyle(color: broadcastgroups[index].selected?Colors.white:Colors.black38),),
                      )
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-.95,0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(color:Colors.white),
                    width: MediaQuery.of(context).size.width*0.1,height: 20,
                    child: const Align(alignment:Alignment.centerLeft,child: Text('To:', style: TextStyle(fontSize:15, color: Colors.cyan),)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15,),
            //same for this??
            Column(
              children: [
                Flexible(
                  child: TextField(
                    enabled: true,
                    expands: true,
                    textCapitalization: TextCapitalization.sentences,
                    controller: msgfield,
                    maxLines: null,
                    minLines: null,
                    style: const TextStyle(color: Colors.black87),
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.cyan),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed: (){}, 
                        child: const Text("SAVE"),
                        style: ElevatedButton.styleFrom(primary: Colors.cyan),
                      ),
                    ),
                    const SizedBox(width: 3,),
                    Expanded(
                      child: ElevatedButton(onPressed: (){}, 
                        child: const Text("SEND"),
                        style: ElevatedButton.styleFrom(primary: Colors.cyan),
                      ),
                    ),
                  ],
                ),
              ],
            )
            
          ],
        ),),
    );
  }
}