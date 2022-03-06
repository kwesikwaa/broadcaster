import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:flutter/material.dart';

class Historypage extends StatefulWidget {
  const Historypage({Key key}) : super(key: key);
  
  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  @override
  Widget build(BuildContext context) {
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
                  itemCount: history.length,//play numbner
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (builder)=>
                          AlertDialog(
                            title: Text('SENT TO ${history[index].totalsent} contacts'),
                            content: Text(history[index].message),
                            actions: [
                              OutlinedButton(onPressed: (){}, child: const Text('DELETE', style: TextStyle(color: Colors.white))),
                              OutlinedButton(onPressed: (){Navigator.pop(context);}, child: const Text('OK', style: TextStyle(color: Colors.white),))
                            ],
                          )
                        );
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
                                child: Text(history[index].message,maxLines: 3,overflow:TextOverflow.ellipsis,),
                              ),color: Colors.grey[600],))),
                            Expanded(flex:2,child: ConstrainedBox(constraints: const BoxConstraints(minHeight: 60),child: Container(child: Align(alignment: Alignment.topRight, 
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(history[index].date,textAlign: TextAlign.left,),
                              )),color: Colors.grey[700],))),
                            Expanded(flex:1,child: ConstrainedBox(constraints: const BoxConstraints(minHeight: 60),child: Container(child: Align(alignment: Alignment.topRight, 
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(history[index].totalsent.toString(),textAlign: TextAlign.left,),
                              )),color: Colors.grey[800],)),),
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