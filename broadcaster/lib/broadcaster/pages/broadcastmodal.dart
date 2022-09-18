import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:broadcaster/broadcaster/pages/groupspage.dart';
import 'package:broadcaster/broadcaster/pages/messagepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BroadcastModal extends StatefulWidget {
  var templist;
  var roundtrip;
  var groupnamecontroller;
  BroadcastModal({ Key key, this.templist, this.roundtrip, this.groupnamecontroller }) : super(key: key);

  @override
  _BroadcastModalState createState() => _BroadcastModalState();
}

class _BroadcastModalState extends State<BroadcastModal> {
  Box bgrouphive = Hive.box<BroadcastGroup>('broadcastgroups');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.groupnamecontroller.clear();
  }

 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(color: Colors.orange[100],
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: size.height*0.8,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 5,
                        child: ListView.builder(
                          itemCount: widget.templist.length,
                          itemBuilder:(context, index){
                            return ListTile(
                              title: Text(widget.templist[index].nametocall, style: const TextStyle(color: Colors.black),),
                              subtitle: Text(widget.templist[index].contact.contact.toString(), style: const TextStyle(color: Colors.black)),
                              trailing: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    
                                    // ContactsClass.allcontacts[index].selected = !ContactsClass.allcontacts[index].selected;
                                    widget.templist.removeAt(index);
                                    if(widget.templist.isEmpty){
                                      Navigator.pop(context);
                                    }
                                    
                              
                                  });
                                },
                                child: const Icon(Icons.remove_circle,size: 30, color: Colors.red,)),
                            );
                          }
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          child: Row(children: [
                            Expanded(
                              child: TextField(
                                controller: widget.groupnamecontroller,
                                style: const TextStyle(color: Colors.black87),
                                  decoration: const InputDecoration( 
                                    labelText: 'group name',
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
                            ElevatedButton(
                              onPressed: (){
                                
                                ContactsClass().savebroadcastlist(
                                  //change name after debuggin
                                  castlist: widget.templist,
                                  groupname: widget.groupnamecontroller.text,
                                  boxtosaveto: bgrouphive,
                                  selected: widget.roundtrip? true: false);
                                if(widget.roundtrip){
                                  //rugged solution
                                  // List<String> temp = [widget.groupnamecontroller.text];
                                 // POP WITH TRUE GOES TO TRIGGER WHENCOMPLETE FXN
                                 
                                  Navigator.pop(context,true);
                                 
                                  // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> Messagepage(selectedlists: temp)));
                                }
                                else{
                                  
                                  Navigator.pop(context);
                                }
                              }, 
                              child: Text('SAVE')
                            )
                          ],),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
  }
}