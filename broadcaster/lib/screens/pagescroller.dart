import 'package:broadcaster/Models/toyItem.dart';
import 'package:flutter/material.dart';

class Pagescroller extends StatefulWidget {
   Pagescroller({Key key}) : super(key: key);
  final List<String> categories = ['Character','Environment','Vfx','Cloth','Pyro','Matte Painting','2d arts'];

  @override
  State <Pagescroller> createState() =>  _PagescrollerState();
}

class  _PagescrollerState extends State<Pagescroller> {
  final _pagecontroler = PageController(viewportFraction: 0.75);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagecontroler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(
                widget.categories.length, 
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.categories[index],
                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),
                ),)
            ),),
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: toys.length,
              controller: _pagecontroler,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 40,bottom: 100),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                      ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Image(image: AssetImage(toys[index].image),fit: BoxFit.fill),
                          ),),
                        Text(toys[index].name, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600, color: Colors.black54),),
                        Text("GHC ${toys[index].price}", style: const TextStyle(fontSize: 32,fontWeight: FontWeight.w700, color: Colors.black54),),
    
                      ],
                    ),
                  ),
                );
              }
            )
          )  
        ],
      ),
    );
  }
}