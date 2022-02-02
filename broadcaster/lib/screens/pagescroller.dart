import 'package:broadcaster/Models/toyItem.dart';
import 'package:flutter/material.dart';

class Pagescroller extends StatefulWidget {
   Pagescroller({Key key}) : super(key: key);
  final List<String> categories = [];

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
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              7, (index) => Text(
                widget.categories[index],
                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),)
          ),),
        Expanded(
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: toys.length,
            controller: _pagecontroler,
            itemBuilder: (context, index){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                  ),
                child: Column(
                  children: [
                    Expanded(child: Image(image: AssetImage(toys[index].image),fit: BoxFit.fill),),
                    Text(toys[index].name, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600, color: Colors.white),),
                    Text("GHC ${toys[index].price}", style: const TextStyle(fontSize: 32,fontWeight: FontWeight.w700, color: Colors.white),),

                  ],
                ),
              );
            }
          )
        )  
      ],
    );
  }
}