import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Historypage extends StatefulWidget {
  const Historypage({Key key}) : super(key: key);
  
  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {

  Box historyhive = Hive.box<History>('history');
  List<History> _history = [];


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    final data = historyhive.values.toList();
    _history = data.reversed.toList();

  }

  @override
  Widget build(BuildContext context) {
    print('eteddd');
    return Scaffold(
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
                    Hero(tag: "history", child: Icon(Icons.history_outlined, color: Colors.grey, size: 40)),
                    Text("SMS HISTORY", style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  //HVINGING
                  itemCount: _history.length,//play numbner
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (builder)=>
                          AlertDialog(
                            backgroundColor: Colors.blueGrey,
                            // title: Text('SENT TO ${_history[index].totalsent} contacts'),
                            content: const Text('You sure say you wan delete am?'),
                            actions: [
                              OutlinedButton(onPressed: (){historyhive.deleteAt(index);_history.removeAt(index);setState(() {
                                Navigator.pop(context);
                              });}, child: const Text('DELETE', style: TextStyle(color: Colors.white))),
                              OutlinedButton(onPressed: (){Navigator.pop(context);}, child: const Text('NAAH', style: TextStyle(color: Colors.white),))
                            ],
                          )
                        );
                      },
                      splashColor: Colors.cyan,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal:6, vertical: 8),
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // height: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(_history[index].message,maxLines: 3,overflow:TextOverflow.ellipsis,)),
                            Container(margin: const EdgeInsets.symmetric(vertical: 10),color: Colors.grey,height: 1,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                        
                              children: [
                                Text(DateFormat.jm().add_yMd().format(_history[index].date),textAlign: TextAlign.left,),
                                Container(
                                    padding: const EdgeInsets.symmetric(horizontal:3),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.group),
                                          const SizedBox(width: 10,),
                                          Text(_history[index].totalsent.toString(),textAlign: TextAlign.left,),
                                        ],
                                      ),
                                    )
                                ),
                              ],                                                                                                    
                            ),                            
                          ],
                        ),
                      ),
                    );
                  }),
              )
            ],
          ),
        ),),
     ),
    );
  }
}