import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:broadcaster/broadcaster/pages/messagepage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class Groupspage extends StatefulWidget {
  final bool roundtrip;
  const Groupspage({Key key, this.roundtrip=false}) : super(key: key);
  
  @override
  State<Groupspage> createState() => _GroupspageState();
}

class _GroupspageState extends State<Groupspage> {

  TextEditingController groupnamecontroller = TextEditingController();
  List<BroadcastContact> broadcastlis = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(broadcastgroups.isNotEmpty){
      print('adrn ${broadcastgroups.last.contactlist.length}');
      print('enght ${broadcastgroups.length}');
    }
    //if roundtrip be true then where you go set the group for be fed with that value..
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ContactsClass().clear();
    groupnamecontroller.dispose();
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context:context, builder:(context){
            print('removing...');
            return Container(color: Colors.orange[100],
              height: MediaQuery.of(context).size.height*0.8,
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                      itemCount: broadcastlis.length,
                      itemBuilder:(context, index){
                        return ListTile(
                          title: Text(broadcastlis[index].nametocall, style: const TextStyle(color: Colors.black),),
                          subtitle: Text(broadcastlis[index].contact.contact.toString(), style: const TextStyle(color: Colors.black)),
                          trailing: GestureDetector(
                            onTap: (){
                              setState(() {
                                
                                // ContactsClass.allcontacts[index].selected = !ContactsClass.allcontacts[index].selected;
                                broadcastlis.removeAt(index);
                                

                              });
                            },
                            child: const Icon(Icons.remove_circle,size: 30, color: Colors.red,)),
                        );
                      }
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                          controller: groupnamecontroller,
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
                            castlist: broadcastlis,
                            groupname: groupnamecontroller.text,
                            selected: widget.roundtrip? true: false);
                          if(widget.roundtrip){
                            Navigator.pop(context);
                          }
                          else{Navigator.pop(context);}
                        }, 
                        child: Text('SAVE')
                      )
                    ],),
                  )
                ],
              ),
            );
          });
        },
        backgroundColor: Colors.orange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_comment_rounded, color: Colors.white,),
            Text(broadcastlis.length.toString(),style: const TextStyle(color: Colors.white),)
        ]),
      ),
      body: SafeArea(
        child: Container(color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: const [
                      Hero(tag: "groups", child: Icon(Icons.contacts_outlined, color: Colors.orange, size: 30)),
                      Text("CONTACTS", style: TextStyle(color: Colors.orange),),
                    ],
                  ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ContactsClass.allcontacts.length,
                  itemBuilder:(context, index){
                    return ListTile(
                      title: Text(ContactsClass.allcontacts[index].name, style: const TextStyle(color: Colors.black),),
                      subtitle: Text(ContactsClass.allcontacts[index].contact, style: const TextStyle(color: Colors.black)),
                      trailing: GestureDetector(
                        onTap: (){
                          setState(() {
                            
                            ContactsClass.allcontacts[index].selected = !ContactsClass.allcontacts[index].selected;
                            
                            ContactsClass().addContactToBroadcastList(index, ContactsClass.allcontacts[index],broadcastlis);

                          });
                        },
                        child: Icon(Icons.add_circle,size: 30, 
                        color: ContactsClass.allcontacts[index].selected?Colors.green[600]:Colors.grey,)),
                    );
                  }
                )
              )
            ],
          ),
        ),),
      ),
    );
  }
}