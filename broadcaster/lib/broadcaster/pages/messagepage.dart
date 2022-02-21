import 'package:broadcaster/broadcaster/data_model_etc.dart';
import 'package:flutter/material.dart';

class Messagepage extends StatefulWidget {
  const Messagepage({Key key}) : super(key: key);
  
  @override
  State<Messagepage> createState() => _MessagepageState();
}


class _MessagepageState extends State<Messagepage> {
  var msgfield = TextEditingController();
  final  _scrontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrontroller.addListener(() { });
  }

  @override
  void dispose() {
    super.dispose();
    msgfield.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(color: Colors.white,
      padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Hero(tag: "message", child: Icon(Icons.message, color: Colors.red, size: 30)),
              const Text('To:', style: TextStyle(color: Colors.cyan),),
              Container(
                decoration:BoxDecoration(border: Border.all(color: Colors.black)),
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  spacing: 4,
                  children: List.generate(broadcastgroups.length, (index) => 
                    OutlinedButton(
                      onPressed: (){
                        setState(() {
                          broadcastgroups[index].selected = !broadcastgroups[index].selected;  
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.cyan.withOpacity(broadcastgroups[index].selected?1:0),
                        side: const BorderSide(width: 1, color: Colors.cyan)),
                      child: Text(broadcastgroups[index].name,
                        style: TextStyle(color: broadcastgroups[index].selected?Colors.white:Colors.black38),),
                    )
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      enabled: true,
                      textCapitalization: TextCapitalization.sentences,
                      controller: msgfield,
                      maxLines: 10,
                      style: const TextStyle(color: Colors.black87),
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        labelStyle: TextStyle(fontSize: 30, color: Colors.cyan),
                        fillColor: Colors.orange,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan)
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(onPressed: (){}, 
                            child: const Text("SAVE"),
                            style: ElevatedButton.styleFrom(primary: Colors.cyan),
                          ),
                        ),
                        const SizedBox(width: 3,),
                        Expanded(
                          child: ElevatedButton(onPressed: (){}, 
                            child: const Text("SEND")
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),),
    );
  }
}