// import 'dart:js';

import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:broadcaster/broadcaster/pages/draftspage.dart';
import 'package:broadcaster/broadcaster/pages/history.dart';
import 'package:flutter/material.dart';

class Messagepage extends StatefulWidget {
  final String message;
  final String id;
  // final 
  

  const Messagepage({Key key, this.message, this.id}) : super(key: key);
  
  @override
  State<Messagepage> createState() => _MessagepageState();
}


class _MessagepageState extends State<Messagepage> {
  var msgfield = TextEditingController();
  final  _scrontroller = ScrollController();

  _movup(){
    print('in move');
    if(_scrontroller.hasClients){
      print('moving');
      _scrontroller.animateTo(_scrontroller.position.maxScrollExtent, duration: const Duration(milliseconds: 200),curve: Curves.ease);
      print('moved');
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.message != null){
      msgfield.text = widget.message;
    }
    _scrontroller.addListener(_movup);
    
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
      body: SafeArea(
        child: Container(color: Colors.white,
        padding: const EdgeInsets.all(10),
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            controller: _scrontroller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Hero(tag: "message", child: Icon(Icons.message, color: Colors.cyan, size: 40)),
                    SizedBox(width: 10,),
                    Text("Type Message", style: TextStyle(color: Colors.grey),),
                  ],
                ),
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
                        runSpacing: 0,
                        children: 
                        [
                          //using the dart collection for operator
                          for(var index=0; index<broadcastgroups.length;index++) 
                            OutlinedButton(
                              onPressed: (){
                                setState(() {
                                  broadcastgroups[index].groupselected = !broadcastgroups[index].groupselected;  
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.cyan.withOpacity(broadcastgroups[index].groupselected?1:0),
                                side: const BorderSide(width: 1, color: Colors.cyan)),
                              child: Text(broadcastgroups[index].groupname,
                                style: TextStyle(color: broadcastgroups[index].groupselected?Colors.white:Colors.black38),),
                            ),
                            //using the dart spread operator
                          ...[
                            OutlinedButton(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              onPressed: (){},
                              child: Container(
                                height: 30, width: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.cyan,
                                  shape: BoxShape.circle
                                ),
                                child: const Align(alignment: Alignment(0,0.5),child: Text('x',style: TextStyle(fontSize: 30,color: Colors.white),)),
                              ),
                            )
                          ]
                        ]
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
                SizedBox(
                  //animate height based on ontap...reduce and increase as an when..
                  height: size.height*0.6,
                  child: Column(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: true,
                          expands: true,
                          onTap: _movup,
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
                            child: ElevatedButton(
                              onPressed: (){
                                if(msgfield.text.trim().length>3){
                                  if(widget.id == null){
                                    var x = broadcastgroups.where((element) => element.groupselected == true).toList();
                                    List<String> selectedlist;
                                    for(var e in x){
                                      selectedlist.add(e.groupname);
                                    }
                                    Draft draft = Draft(
                                      id: DateTime.now().toString(),
                                      message: msgfield.text,
                                      contactlists: selectedlist
                                    );
                                    drafts.add(draft);
                                    //hive save
                                  }
                                  else{
                                    //update draft values
                                    for (var element in drafts) {
                                      if(element.id == widget.id){
                                        element.message = msgfield.text;
                                        // element.contactlists =
                                        
                                      }
                                    }
                                  }
                                  msgfield.text = '';
                                  broadcastgroups.map((e) => e.groupselected = false);
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=> const Draftspage()));
                                }
                              }, 
                              child: const Text("SAVE"),
                              style: ElevatedButton.styleFrom(primary: Colors.cyan),
                            ),
                          ),
                          const SizedBox(width: 3,),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: ()async {
                                // one takes care of filter the other doesnt
                                var sendnew = Sendmessage();
                                await sendnew.send(msgfield.text, broadcastgroups);
                                // await Sendmessage().send(msgfield.text, broadcastgroups.where((element) => element.groupselected == true).toList());
                                History hist = History(
                                  date: DateTime.now().toString(),
                                  message: msgfield.text,
                                  totalsent: sendnew.totalsent //replace this
                                );
                                history.add(hist);
                                msgfield.text = '';
                                broadcastgroups.map((e) => e.groupselected = false);
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> const Historypage()));
                              }, 
                              child: const Text("SEND"),
                              style: ElevatedButton.styleFrom(primary: Colors.cyan),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                
              ],
            ),
          ),),
      ),
    );
  }
}