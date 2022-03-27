import 'package:telephony/telephony.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';



class Switchy{
  static bool open = false;
}

List<BroadcastGroup>  broadcastgroups = [];
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
  String id;
  String message;
  List<String> contactlists;

  Draft({this.id, this.message, this.contactlists});
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
  int totalsent = 0;

  send(String msgfield, List<BroadcastGroup> castlist) async{
    bool ithasname = msgfield.contains("@namehere") ? true : false;    
    if(msgfield != null && castlist.isNotEmpty){
        List<BroadcastGroup> templist = [];
        //add selected groups to tepmlist eg. hood, jss mates etc
        // taken care of in UI??
        for(var group in castlist){
          if(group.groupselected){
            templist.add(group);
          }
        }
        for(BroadcastGroup eachgroup in templist) //eg. uni mates
        {
          for(BroadcastContact eachcontact in eachgroup.contactlist){
            var name = eachcontact.nametocall;
            var contact = eachcontact.contact.contact;
            var message = ithasname ? msgfield.replaceAll("@namehere", name) : msgfield;
            totalsent ++;
            await telephony.sendSms(to: contact, message: message);
          }
        }       
    }
  }
}

/// CONTACTS RELATED
/// 
class PhoneContact{
  String contact;
  bool selected = false;
  String name;

  PhoneContact({this.contact, this.selected, this.name});   
}
class BroadcastContact{
  PhoneContact  contact;
  String nametocall;

  BroadcastContact({@required this.contact, this.nametocall});
}

class BroadcastGroup{
  String groupname;
  bool groupselected = false;
  List<BroadcastContact> contactlist = [];

  BroadcastGroup({this.groupname, this.groupselected, this.contactlist});
}

class ContactsClass{
  static List<PhoneContact> allcontacts =[];
  List<BroadcastContact> broadcastlist = [];

  permit() async{
    var pstatus = await Permission.contacts.status;
    
    if(!pstatus.isGranted){
      await Permission.contacts.request();
      await Permission.sms.request();
      getcontacts();
    }
    else if(allcontacts.isEmpty){
      getcontacts();
    }
  }

  //pull up for refresh too
  getcontacts() async{
    allcontacts.clear();
    List<Contact> mycontacts = (await ContactsService.getContacts()).toList(); 
    for(var element in mycontacts){
      if(element.phones.isNotEmpty){
        for (var variable in element.phones){
          if(variable.value.length > 8){
            PhoneContact onecontact;
            onecontact.name = element.displayName;
            onecontact.contact = variable.value;
            allcontacts.add(onecontact);
          }
        } 
      }
    }
  }

  addContactToBroadcastList(int index, PhoneContact con){
    if(!con.selected){
      broadcastlist.removeWhere((element)=> element.contact == con);
    }
    else{
      BroadcastContact x = BroadcastContact(contact: allcontacts[index], nametocall: allcontacts[index].name);
      broadcastlist.add(x);
    }
  }
  savebroadcastlist({List<BroadcastContact> broadcastlist, String groupname, bool selected}){
    BroadcastGroup onegroup = BroadcastGroup(groupname: groupname, contactlist: broadcastlist, groupselected: selected);
    // get a place to keep these.. locally or a db
    broadcastgroups.add(onegroup);
  }
}