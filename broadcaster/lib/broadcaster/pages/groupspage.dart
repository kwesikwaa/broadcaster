import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:broadcaster/broadcaster/pages/broadcastmodal.dart';
import 'package:broadcaster/broadcaster/pages/messagepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
  Box bcgrouphive = Hive.box<BroadcastGroup>('broadcastgroups');
  int selectedtab = 0;

  List<BottomNavigationBarItem> bottom = const [
    BottomNavigationBarItem(icon: Icon(Icons.contact_page_outlined), label:'contacts' ),
    BottomNavigationBarItem(icon: Icon(Icons.group_outlined),label:'groups '),
  ];

  

  @override
  void initState() {
    super.initState();
    bcgrouphive.values.toList().reversed.toList();
    if(bcgrouphive.isNotEmpty){
      // print('adrn ${broadcastgroups.last.contactlist.length}');
      // print('enght ${broadcastgroups.length}');
    }
    //if roundtrip be true then where you go set the group for be fed with that value..
  }

  @override
  void dispose() {
    super.dispose();
    ContactsClass().clear();
    groupnamecontroller.dispose();
    
  }
  

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
    SafeArea(
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
                        child: Icon(Icons.add_circle,size: 35, 
                        color: ContactsClass.allcontacts[index].selected?Colors.orange:Colors.grey,)),
                    );
                  }
                )
              )
            ],
          ),
        ),),
      ),
    SafeArea(child: Container(
      child: ListView.builder(
        itemCount: bcgrouphive.values.toList().length,
        itemBuilder: (context, index){
          var cont = bcgrouphive.values.toList();
          return InkWell(
                      onTap: (){
                        // showDialog(context: context, builder: (builder)=>
                        //   AlertDialog(
                        //     title: Text('SENT TO ${_history[index].totalsent} contacts'),
                        //     content: Text(_history[index].message),
                        //     actions: [
                        //       OutlinedButton(onPressed: (){historyhive.deleteAt(index);_history.removeAt(index);setState(() {
                        //         Navigator.pop(context);
                        //       });}, child: const Text('DELETE', style: TextStyle(color: Colors.white))),
                        //       OutlinedButton(onPressed: (){Navigator.pop(context);}, child: const Text('OK', style: TextStyle(color: Colors.white),))
                        //     ],
                        //   )
                        // );
                      },
                      splashColor: Colors.cyan,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(flex:4,child: ConstrainedBox(constraints: const BoxConstraints(minHeight: 60),child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(cont[index].groupname,maxLines: 3,overflow:TextOverflow.ellipsis,),
                              ),color: Colors.grey[600],))),
                            Expanded(flex:2,child: ConstrainedBox(constraints: const BoxConstraints(minHeight: 60),child: Container(child: Align(alignment: Alignment.topRight, 
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(cont[index].contactlist.length.toString(),textAlign: TextAlign.left,),
                              )),color: Colors.grey[700],))),
                            // Expanded(flex:1,child: ConstrainedBox(constraints: const BoxConstraints(minHeight: 60),child: Container(child: Align(alignment: Alignment.topRight, 
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(5.0),
                            //     child: Text(cont[index].totalsent.toString(),textAlign: TextAlign.left,),
                            //   )),color: Colors.grey[800],)),),
                          ],
                        ),
                      ),
                    );
        })
    ))
  ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar( 
        items: bottom,
        currentIndex:  selectedtab,
        onTap: (index){setState(() {selectedtab = index;});},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if(broadcastlis.isNotEmpty){
            await showModalBottomSheet(
              context:context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))
              ),
              isScrollControlled: true,
              //split it out for setstate to work on modalsheet
              builder:(_)=>BroadcastModal(templist: broadcastlis,roundtrip: widget.roundtrip,groupnamecontroller: groupnamecontroller,)
            ).whenComplete((){
              //SOLUTION FOR UNTICKING MAINS JERKY??? YET TO FIND OUT
              
              if(widget.roundtrip){
                // ONE SOLUTION.... it works
              
                Navigator.pop(context);

                // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                // print('we back in');
                // List<String> temp = [broadcastgroups.last.groupname];
                // return Messagepage(selectedlists: temp);}));
              }
              else{
                ContactsClass.allcontacts.map((e) => e.selected=false).toList();
                
                setState(() {
                  broadcastlis = [];
                });
                
              }
              
            });
          }
        },
        backgroundColor: broadcastlis.isNotEmpty?Colors.orange:Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_comment_rounded, color: Colors.white,),
            Text(broadcastlis.length.toString(),style: const TextStyle(color: Colors.white),)
        ]),
      ),
      body: IndexedStack(index: selectedtab, children: [...tabs],)
    );
  }
}