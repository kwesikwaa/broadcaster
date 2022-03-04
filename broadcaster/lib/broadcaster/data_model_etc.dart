import 'package:telephony/telephony.dart';
import 'package:flutter/material.dart';

class BroadcastGroups{
  String name;
  bool selected = false;
  // List<int> bunch = [];

  BroadcastGroups({this.name, this.selected});
}

class Switchy{
  static bool open = false;
}

List<BroadcastGroups> broadcastgroups = [
  BroadcastGroups(name:"church", selected: false),
  BroadcastGroups(name:"jss mates", selected: false),
  BroadcastGroups(name:"ss mates", selected: false),
  BroadcastGroups(name:"legon mates", selected: false),
  BroadcastGroups(name:"work group", selected: false),
  BroadcastGroups(name:"hood", selected: false),
  BroadcastGroups(name:"football joint", selected: false),
];

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

  _send(final msgfield, List cast) async{
    if(msgfield.text != null && cast.isNotEmpty){
      if(msgfield.text.contains("@name")){
        cast.forEach((element) {
          var z = msgfield.text.replaceAll("@name", element.salutation); 
          y.add(z);
          // y.add; 
        });
        _smsconnection(cast);
        _donedialog(y);  
      }
      else{
        for( var i in cast){
          y.add(msgfield.text);
        }
        _smsconnection(cast);
        _donedialog(y);  
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