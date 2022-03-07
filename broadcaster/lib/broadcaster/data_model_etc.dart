import 'package:telephony/telephony.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class BroadcastGroups{
  String name;
  bool selected = false;
  List<BroadcastContact> listy = [];

  BroadcastGroups({this.name, this.selected, this.listy});
}

class Switchy{
  static bool open = false;
}

//create auto group name eg group1 group2 group3
List<BroadcastGroups>  broadcastgroups = [
  // BroadcastGroups(name:"church", selected: false, listy: xxxx),
  // BroadcastGroups(name:"jss mates", selected: false),
  // BroadcastGroups(name:"ss mates", selected: false),
  // BroadcastGroups(name:"legon mates", selected: false),
  // BroadcastGroups(name:"work group", selected: false),
  // BroadcastGroups(name:"hood", selected: false),
  // BroadcastGroups(name:"football joint", selected: false),
];

List<History> history = [
  History(totalsent: 10, date: '30/07/2022', message: 'Yo we dey town today anaa'),
  History(totalsent: 25, date: '02/04/2022', message: 'Hello Sign up to our new packag '),
  History(totalsent: 12, date: '26/08/2022', message: 'we have introduce a new deal kindly take time to go through'),
  History(totalsent: 7, date: '18/12/2022', message: 'Chale the match dey go on so make we postpone the tin'),
  History(totalsent: 62, date: '10/01/2022', message: 'The monkey business all for end chale'),
  History(totalsent: 35, date: '06/03/2022', message: 'The oyarifa traffic just be myth aswear! nothing like that dey'),
  History(totalsent: 11, date: '28/02/2022', message: 'Hi, make a date with us '),
  History(totalsent: 23, date: '10/05/2022', message: 'Kindly follow the link to be put on the daily something'),
  History(totalsent: 42, date: '09/09/2022', message: 'Everything go fall in the right place'),
  History(totalsent: 10200, date: '24/14/2022', message: 'Tech no be hype chale'),
  History(totalsent: 87, date: '22/06/2022', message: 'The date for the workshop has been moved furhter to the so and so be on the look out for it. Same venue, same agenda'),
];
List<Draft> drafts = [];

class Draft{
  String message;
  List<BroadcastGroups> contactlists;

  Draft({this.message, this.contactlists});
}

class History{
  String message;
  int totalsent;
  String date;

  History({this.message, this.totalsent, this.date});
}

class Sendmessage{
  final Telephony telephony = Telephony.instance;
  final history = History();
  var y = [];

  _send(final msgfield, List<BroadcastGroups> castlist) async{
    if(msgfield.text != null && castlist.isNotEmpty){
      if(msgfield.text.contains("@namehere")){
        List<BroadcastGroups> templist = [];
        //add selected groups to tepmlist eg. hood, jss mates etc
        for(var group in castlist){
          if(group.selected){
            templist.add(group);
          }
        }
        for(BroadcastGroups eachgroup in templist){
          for(BroadcastContact eachcontact in eachgroup.listy){
            var name = eachcontact.nametocall;
            //was it one contact selected or many??
            var contacts = eachcontact.contact.contacts;


          }
        }

        castlist.forEach((element) {
          var z = msgfield.text.replaceAll("@name", element); 
          y.add(z);
          // y.add; 
        });
        for(var x in broadcastgroups){
          if(x.selected){
            _smsconnection(castlist);
          //add to history here
          _donedialog(y);  
          }
        }
      }

      else{
        for( var i in castlist){
          y.add(msgfield.text);
        }
        for(var x in broadcastgroups){
          if(x.selected){
            _smsconnection(castlist);
          //add to history here
          _donedialog(y);  
          }
        }
      }
    }
  }
  _smsconnection(final cast)async{
    for(int i=0;i<y.length; i++){
          var w = cast[i].contact.contact.phones.elementAt(0).value.toString();
          var m = y[i];
          await telephony.sendSms(to: w, message: m);
        }
  }

  _donedialog(msg){
    showModalBottomSheet(
      // context: context, 
      builder: (BuildContext context){
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text('Chale! ${msg.length} total sms sent', style: TextStyle(color: Colors.yellow[500])),
              //wrap this in a fixed size
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: msg.length,
                    itemBuilder: (context, index)
                    {
                     return BubbleSpecialTwo(
                       text: msg[index],
                       tail: true,
                       isSender: true,
                       sent: true,
                       delivered: true,
                     );
                    }),
                ),
              ),
              ElevatedButton(onPressed: (){Navigator.pop(context);}, child: const Text('OK'))
            ],
          ),
        ),
      );
    });
  }

  

}

class PhoneContact{
  List contacts;
  bool selected = false;
  String name;

  PhoneContact({this.contacts, this.selected, this.name});   
}
class BroadcastContact{
  PhoneContact  contact;
  String nametocall;

  BroadcastContact({@required this.contact,@required this.nametocall});
}

class ContactsClass{
  static List<PhoneContact> allcontacts =[];
  static List<BroadcastContact> broadcastlist = [];

  _permit() async{
    var pstatus = await Permission.contacts.status;
    
    if(!pstatus.isGranted){
      await Permission.contacts.request();
      await Permission.sms.request();
      _getcontacts();
    }
    else{_getcontacts();}
  }

  _getcontacts() async{
    List<Contact> _c = (await ContactsService.getContacts()).toList(); 
    setState(() {
      _c.forEach((element) {
        
        if(element.phones.isNotEmpty){
          PhoneContact onecontact;
          onecontact.name = element.displayName;
          for (var x in element.phones){
            if(x.value.length > 8){
              onecontact.contacts.add(x);
            }
          } 
          allcontacts.add(onecontact);
        }
       });
      });
  }

  _addContactToBroadcastList(int index, PhoneContact con){
    if(!con.selected){
      broadcastlist.removeWhere((element)=> element.contact == con);
    }
    else{
      BroadcastContact x = BroadcastContact(contact: allcontacts[index], nametocall: allcontacts[index].name);
      broadcastlist.add(x);
    }
  }
}