import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:broadcaster/broadcaster/pages/messagepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Draftspage extends StatefulWidget {
  const Draftspage({Key key}) : super(key: key);
  
  @override
  State<Draftspage> createState() => _DraftspageState();
}

class _DraftspageState extends State<Draftspage> {

  Box draftshive = Hive.box<Draft>('drafts');
  List<Draft> _drafts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final data = draftshive.values.toList();
    _drafts = data.reversed.toList();
  }

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
                      Hero(tag: "drafts", child: Icon(Icons.drafts, color: Colors.brown, size: 40)),
                      Text("DRAFTS", style: TextStyle(color: Colors.brown),),
                    ],
                  ),
                ),
              Expanded(
                  child: ListView.builder(
                    itemCount: _drafts.length,//play numbner
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> Messagepage(message: _drafts[index].message,id:_drafts[index].id,selectedlists: _drafts[index].contactlists)));
                        },
                        splashColor: Colors.cyan,
                        child: Container(
                        padding: const EdgeInsets.symmetric(horizontal:6, vertical: 8),
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // height: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(_drafts[index].message,maxLines: 3,overflow:TextOverflow.ellipsis,)),
                            Container(margin: const EdgeInsets.symmetric(vertical: 10),color: Colors.white,height: 1,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                        
                              children: [
                                // Text(_drafts[index].date.toIso8601String(),textAlign: TextAlign.left,),
                                Container(
                                    padding: const EdgeInsets.symmetric(horizontal:3),
                                    decoration: BoxDecoration(
                                      color: Colors.brown[200],
                                      borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.groups_sharp),
                                          const SizedBox(width: 10,),
                                          Text(_drafts[index].contactlists.length.toString(),textAlign: TextAlign.left,),
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