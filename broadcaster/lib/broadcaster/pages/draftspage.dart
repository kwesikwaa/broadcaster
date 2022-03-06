import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:broadcaster/broadcaster/pages/messagepage.dart';
import 'package:flutter/material.dart';

class Draftspage extends StatefulWidget {
  const Draftspage({Key key}) : super(key: key);
  
  @override
  State<Draftspage> createState() => _DraftspageState();
}

class _DraftspageState extends State<Draftspage> {
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
                    itemCount: drafts.length,//play numbner
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> Messagepage(message: drafts[index].message)));
                        },
                        splashColor: Colors.cyan,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(flex:4,child: ConstrainedBox(constraints: const BoxConstraints(minHeight: 50),child: Container(child: Text(drafts[index].message,maxLines: 3,overflow:TextOverflow.ellipsis,),color: Colors.grey[600],))),
                              // Expanded(flex:2,child: ConstrainedBox(constraints: const BoxConstraints(minHeight: 50),child: Container(child: Align(alignment: Alignment.topRight, child: Text(drafts[index].date,textAlign: TextAlign.left,)),color: Colors.grey[700],))),
                              Expanded(flex:1,child: ConstrainedBox(constraints: const BoxConstraints(minHeight: 50),child: Container(child: Align(alignment: Alignment.topRight, child: Text(drafts[index].contactlists.length.toString(),textAlign: TextAlign.left,)),color: Colors.grey[800],)),),
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