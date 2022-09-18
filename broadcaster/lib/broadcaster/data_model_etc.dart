import 'package:hive/hive.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

part 'data_model_etc.g.dart';



class Switchy{
  static bool open = false;
}

//open these boxes in hive on init

List<BroadcastGroup>  broadcastgroups = [];
List<History> history = [];
List<Draft> drafts = [];

@HiveType(typeId: 0)
class Draft{
  @HiveField(0)
  String id;
  @HiveField(1)
  String message;
  @HiveField(2)
  List<String> contactlists;

  Draft({this.id, this.message, this.contactlists});
}

@HiveType(typeId: 1)
class History{
  @HiveField(0)
  String message;
  @HiveField(1)
  int totalsent;
  @HiveField(2)
  DateTime date;

  History({this.message, this.totalsent, this.date});
}

class Sendmessage{
  final Telephony telephony = Telephony.instance;
  // final history = History();
  var y = [];
  int totalsent = 0;

  send(String msgfield, List<BroadcastGroup> castlist)async{
    bool ithasname = msgfield.contains("@namehere") ? true : false;    
    List<BroadcastGroup> templist = [];
    //add selected groups to tepmlist eg. hood, jss mates etc
    // taken care of in UI??
    for(var group in castlist){
      if(group.groupselected){
        templist.add(group);
      }
    }
    print('here anaa');
    print(templist.length);
    for(BroadcastGroup eachgroup in templist) //eg. uni mates
    {
      
      for(BroadcastContact eachcontact in eachgroup.contactlist){
        print('sending...');
        var name = eachcontact.nametocall;
        var contact = eachcontact.contact.contact;
        var message = ithasname ? msgfield.replaceAll("@namehere", name) : msgfield;
        print(name);
        print(contact);
        print(message);
        totalsent ++;
        await telephony.sendSms(to: contact, message: message);
      }
    }  
    History hist = History(
        date: DateTime.now(),
        message: msgfield,
        totalsent: totalsent //replace this
      );
    // history.add(hist);
    // if both will be on memeory why not take out the above
    // await Hive.openBox<History>('history').then((value) => value.put('hist.date', hist));
    Hive.box<History>('history').add(hist);
  }
}

/// CONTACTS RELATED
/// 
@HiveType(typeId: 2)
class PhoneContact{
  @HiveField(0)
  String contact;
  @HiveField(1)
  bool selected = false;
  @HiveField(2)
  String name;

  PhoneContact({this.contact, this.selected, this.name});   
}

@HiveType(typeId: 3)
class BroadcastContact{
  @HiveField(0)
  PhoneContact  contact;
  @HiveField(1)
  String nametocall;

  BroadcastContact({@required this.contact, this.nametocall});
}


@HiveType(typeId: 4)
class BroadcastGroup extends HiveObject{
  @HiveField(0)
  String groupname;
  @HiveField(1)
  bool groupselected = false;
  @HiveField(2)
  List<BroadcastContact> contactlist;

  BroadcastGroup({this.groupname, this.groupselected, this.contactlist});
}

class ContactsClass{
  static List<PhoneContact> allcontacts =[];
  List<BroadcastContact> broadcastlist = [];
  

  permit() async{
    print('start enght ${allcontacts.length}');
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
            PhoneContact onecontact = PhoneContact(selected: false);
            onecontact.name = element.displayName??variable.value;
            onecontact.contact = variable.value.trim();
            allcontacts.add(onecontact);
          }
        } 
      }
    }
    //run a sort operation here
    allcontacts.sort((a,b)=> a.name.compareTo(b.name));
    
    // allcontacts.removeWhere((element)=>element.contact == element.contact.codeUnitAt(1));
    print(allcontacts.length);
  }

  addContactToBroadcastList(int index, PhoneContact con,List<BroadcastContact> broad){
    if(!con.selected){
      broad.removeWhere((element)=> element.contact == con);
    }
    else{
      BroadcastContact x = BroadcastContact(contact: allcontacts[index], nametocall: allcontacts[index].name);
      broad.add(x);
    }
  }
  clear(){
    // broadcastlist.clear();
    allcontacts.map((e) => e.selected=false).toList();
  }
  savebroadcastlist({List<BroadcastContact> castlist, String groupname, bool selected, Box boxtosaveto}){
    BroadcastGroup onegroup = BroadcastGroup(groupname: groupname, contactlist: castlist, groupselected: selected);
    boxtosaveto.add(onegroup);
    // broadcastgroups.add(onegroup);
    print(boxtosaveto);
    print(boxtosaveto.values.length);
    print(boxtosaveto.values.first);
    print(boxtosaveto.values.toList());
    for(var d in boxtosaveto.values){
      print(d.groupname);
      print(d.contactlist.length);
    }
  }
}