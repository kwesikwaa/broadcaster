// import 'dart:js';

import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:broadcaster/broadcaster/pages/draftspage.dart';
import 'package:broadcaster/broadcaster/pages/groupspage.dart';
import 'package:broadcaster/broadcaster/pages/history.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Messagepage extends StatefulWidget {
  final String message;
  final String id;
  final List<String> selectedlists;
  // final 
  

  const Messagepage({Key key, this.message, this.id, this.selectedlists}) : super(key: key);
  
  @override
  State<Messagepage> createState() => _MessagepageState();
}


class _MessagepageState extends State<Messagepage> {
  var msgfield = TextEditingController();
  final  _scrontroller = ScrollController();

  Box bcgrouphive = Hive.box<BroadcastGroup>('broadcastgroups');
  Box drafthive = Hive.box<Draft>('drafts');

  _movup(){
    // print('in move');
    if(_scrontroller.hasClients){
      // print('moving');
      _scrontroller.animateTo(_scrontroller.position.maxScrollExtent, duration: const Duration(milliseconds: 200),curve: Curves.ease);
      // print('moved');
    }
  }

  @override
  void initState() {
    super.initState();
    // if(broadcastgroups.isNotEmpty)print(broadcastgroups.last.contactlist.length);
    // bcgrouphive.values.toList();
    print(bcgrouphive.values.last.contactlist.length);
    for(var d in bcgrouphive.values.last.contactlist){
      print(d.nametocall);
      print(d.contact.contact);
    }
    if(widget.selectedlists != null && widget.selectedlists.isNotEmpty){
      for(var x in widget.selectedlists){
        bcgrouphive.values.toList().map((e){
          if(e.groupname == x){
            e.groupselected = true;
          }
        }).toList();
      }
    }
    if(widget.message != null){
      msgfield.text = widget.message;
      
    }
    _scrontroller.addListener(_movup);
    
  }

  @override
  void dispose() {
    super.dispose();
    msgfield.dispose();
    broadcastgroups.map((e) => e.groupselected=false).toList();
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
                          for(var index=0; index<bcgrouphive.length;index++) 
                            OutlinedButton(
                              onPressed: (){
                                setState(() {
                                  bcgrouphive.values.toList()[index].groupselected = !bcgrouphive.values.toList()[index].groupselected;  
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.cyan.withOpacity(bcgrouphive.values.toList()[index].groupselected?1:0),
                                side: const BorderSide(width: 1, color: Colors.cyan)),
                              child: Text(bcgrouphive.values.toList()[index].groupname,
                                style: TextStyle(color:bcgrouphive.values.toList()[index].groupselected?Colors.white:Colors.black38),),
                            ),
                            //using the dart spread operator
                          ...[
                            IconButton(
                              onPressed: (){
                                //added when complete to solve the layering problem
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> const Groupspage(roundtrip: true,))).whenComplete(
                                  () => setState((){}));
                                //sovring a proving ruggedly
                                
                              }, 
                              icon: const Icon(Icons.add_circle,color:Colors.cyan, size: 30,))
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
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: (){
                                  if(msgfield.text.trim().length>3){
                                    if(widget.id == null){
                                      var x = bcgrouphive.values.where((element) => element.groupselected == true).toList();
                                      List<String> selectedlist = [];
                                      for(var e in x){
                                        selectedlist.add(e.groupname);
                                      }
                                      Draft draft = Draft(
                                        id: DateTime.now().toString(),
                                        message: msgfield.text,
                                        contactlists: selectedlist
                                      );
                                      // drafts.add(draft);
                                      //hive save
                                      drafthive.add(draft);
                                      
                                    }
                                    else{
                                      //update draft value
                                      //COME BACK TO HIVE THIS ONE AS WELL
                                      var x = bcgrouphive.values.where((element) => element.groupselected == true).toList();
                                      List<String> selectedlist = [];
                                      for(var e in x){
                                        selectedlist.add(e.groupname);
                                      }
                                      for (var element in drafts) {
                                        if(element.id == widget.id){
                                          element.message = msgfield.text;
                                          element.contactlists = selectedlist;
                                          // element.contactlists =
                                        }
                                      }
                                    }
                                    msgfield.text = '';
                                    bcgrouphive.values.map((e) => e.groupselected = false);
                                    
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const Draftspage()));
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
                                  var x = bcgrouphive.values.where((element) => element.groupselected == true).toList();
                                  if(msgfield !=null && x.isNotEmpty){
                                    var sendnew = Sendmessage();
                                    await sendnew.send(msgfield.text, bcgrouphive.values.toList());
                                    // await Sendmessage().send(msgfield.text, broadcastgroups.where((element) => element.groupselected == true).toList());
                                    msgfield.text = '';
                                    bcgrouphive.values.map((e) => e.groupselected = false);
                                    //remove from draft if draft is sent
                                    if(widget.id != null){
                                      drafthive.delete((element) => element.id==widget.id);
                                      
                                    }
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const Historypage()));
                                  }
                                }, 
                                child: const Text("SEND"),
                                style: ElevatedButton.styleFrom(primary: Colors.cyan),
                              ),
                            ),
                          ],
                        ),
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