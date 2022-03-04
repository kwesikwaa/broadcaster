
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:contacts_service/contacts_service.dart';
// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class AddtoBroadcast{
  MyContact contact;
  String salutation;

  AddtoBroadcast({@required this.contact, @required this.salutation});
}

class MyContact{
  Contact contact;
  bool selected = false;
  String name;
  
  MyContact({this.contact, this.selected, this.name});
}


class Broadcaster extends StatefulWidget {

  @override
  _BroadcasterState createState() => _BroadcasterState();
}

class _BroadcasterState extends State<Broadcaster> {

  final Telephony telephony = Telephony.instance;
  List<MyContact> contacts = [];
  List<AddtoBroadcast> cast = [];
  List<MyContact> broadcastlIST = [];

  final modaltext = TextEditingController();
  final msgfield = TextEditingController();

  initState(){
    print('init');
    _permit();
    super.initState();
    print('done inbit');
  }

  _permit() async{
    print('inide permit');
    var pstatus = await Permission.contacts.status;
    
    if(!pstatus.isGranted){
      await Permission.contacts.request();
      await Permission.sms.request();
      print('went through status check');
      _getcontacts();
    }
    else{_getcontacts();}
  }
  
  _getcontacts() async{
    print('getting contacts');
    List<Contact> _c = (await ContactsService.getContacts()).toList(); 
    setState(() {
      _c.forEach((element) {
        if(element.phones.isNotEmpty){
          for (var x in element.phones){
            if(x.value.length > 10){
              contacts.add(MyContact(contact: element, selected: false));
              break;
            }
          } 
        }
       });
      });

    //just for checks,,,, nothing serious
    var x = 0;
    contacts.forEach((element) {
      if(element.contact.displayName.length>0){
        x++; 
      }
    });
    print('with names: ${x}');
    print('TOTAl filtered: ${contacts.length}');
  }

_addtoBroadcast(int index, MyContact w){ 
    if(!w.selected){
      cast.removeWhere((element) => element.contact == w);
    }
    else{
      AddtoBroadcast x = AddtoBroadcast(contact: contacts[index], salutation: "salutation");
      cast.add(x);}
}


  _newContactCheck() async{
    //checking to see if additional contact have been added to the address book
    // this is to be called inside a refresh call or wheneever user opens contacts
    // List<Contact> _c = await ContactsService.getContacts(); 
    // _c.forEach((element) {
    //   var n = element.phones.elementAt(0);
    //   contacts.forEach((e) { 
    //     var z = e.phones.elementAt(0);
    //     if(z != n){
    //       contacts.add(element); 
    //       contacts.sort();
    //     }
    //   });
    // });
    
  }
  
  



  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text('Broadcaster'),),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children:[ 
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: s.height*.68,
                    width: s.width/2,
                    child: cast.isEmpty?Center(child:Text('Empty List',textAlign: TextAlign.right,)):
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: cast.length,
                            itemBuilder: (context, index){
                              var thiscontact = cast[index];
                              return GestureDetector(
                                //make changes for auto keyboard adjustment
                                onTap: (){/*_modaltins(context,s.height*0.6,thiscontact);*/},
                                child: Card(
                                  child: ListTile(
                                    title: Text(thiscontact.contact.contact.displayName),
                                    subtitle: Text(thiscontact.salutation),
                                    // leading: CircleAvatar(child: Text(thiscontact.initials(),style: TextStyle(color: Colors.white))),
                                    trailing: IconButton(icon: Icon(Icons.delete, size: 15, color: Colors.red),onPressed:(){setState(() {
                                      thiscontact.contact.selected = false;
                                      cast.remove(thiscontact);
                                    });})
                                  ),
                                ),
                              );
                            }
                            ),
                    // color: Colors.grey[900],
                  )
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: s.height*.68,
                    color: Colors.grey[800],
                    width: s.width/2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      // ONLY USE SHRINKWARP COS A SCROLLABLE LISTVIEW IS NESTED IN A COLUMN
                      itemCount: contacts.length,
                      itemBuilder: (context, index){
                        var thiscontact = contacts[index];
                        return Card(
                          child: ListTile(
                            title: Text(thiscontact.contact.displayName),
                            subtitle: Text(thiscontact.contact.phones.elementAt(0).value),
                            // leading: CircleAvatar(child: Text(thiscontact.initials(),style: TextStyle(color: Colors.white))),
                            trailing: IconButton(icon: Icon(Icons.thumb_up, size: 15, color: thiscontact.selected?Colors.green:Colors.grey[700],),
                            onPressed:(){setState(() {
                              thiscontact.selected = !thiscontact.selected;
                              _addtoBroadcast(index,thiscontact);
                            });})
                          ),
                        );
                      }
                      ),
                  ),
                ),
                ]
              ),
              Container(
                  width: s.width,
                  height: s.height*.2,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              maxLines: 500,
                              enabled: true,
                              textCapitalization: TextCapitalization.sentences,
                              controller: msgfield,
                              decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.grey[800],
                              focusColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            ),
                          ),
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){/*_sendmsg();*/},
                          child: Container(
                            child: Center(child:(Text('SEND'))),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10))
                            )),
                        )
                        )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
       
    );
  }

}


