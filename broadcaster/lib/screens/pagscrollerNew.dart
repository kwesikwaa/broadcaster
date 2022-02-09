import 'dart:ui';

import 'package:broadcaster/Models/toyItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Pagescroller extends StatefulWidget {
   Pagescroller({Key key}) : super(key: key);
  final List<String> categories = ['Character','Environment','Vfx','Cloth','Pyro','Matte Painting','2d arts'];

  @override
  State <Pagescroller> createState() =>  _PagescrollerState();
}

class  _PagescrollerState extends State<Pagescroller> {
  final _pagecontroler = PageController(viewportFraction: 0.75, initialPage: 1);
  final bottomitems = [
    const BottomNavigationBarItem(icon: Icon(Icons.laptop),label: 'xx'),
    const BottomNavigationBarItem(icon: Icon(Icons.leaderboard),label: 'yy'),
    const BottomNavigationBarItem(icon: Icon(Icons.library_add),label:'zz')
  ];
  double curindex=1;
  double indexpage=1;
  
  
  _listen(){
    setState(() {
      curindex = _pagecontroler.page;
      double calc = curindex - curindex.truncateToDouble();

      if(_pagecontroler.position.userScrollDirection == ScrollDirection.reverse){
        if(calc > 0.7){
          indexpage = curindex.ceilToDouble();
          
        }
        else{indexpage = curindex.floorToDouble();}
      }
      if(_pagecontroler.position.userScrollDirection == ScrollDirection.forward){
        if(calc < 0.7){
          indexpage = curindex.floorToDouble();
        }
        else{indexpage = curindex.ceilToDouble();}
      }
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagecontroler.addListener(_listen);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagecontroler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1500),
            child: Container(
              key: ValueKey(toys[indexpage.toInt()].name),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(toys[indexpage.toInt()].image))
                ),
              child:BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
                )
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(20, (index) => Card(color: Colors.lime, child:ListTile(title: Text("I be number $index"),))),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FractionallySizedBox(
                  heightFactor: 1,
                  child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: toys.length,
                      controller: _pagecontroler,
                      itemBuilder: (context, index){
                        return FractionallySizedBox(
                          widthFactor: 0.85,
                          child: AnimatedContainer(
                            clipBehavior: Clip.hardEdge,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.bounceInOut,
                            margin: EdgeInsets.only(top: index==indexpage?20:40,bottom: 5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                                
                                image: AssetImage(toys[index].image),
                                fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [Align(
                                alignment: Alignment.bottomLeft,
                                child: FittedBox(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.3),
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(toys[index].name, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600, color: Colors.amber),),
                                          Text("GHC ${toys[index].price}", style: const TextStyle(fontSize: 32,fontWeight: FontWeight.w700, color: Colors.amber),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),]
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(
                            widget.categories.length, 
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedButton(
                                style: const ButtonStyle(),
                                onPressed: (){},
                                child: Text(
                                  widget.categories[index],
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.greenAccent),),
                              ),
                            ),)
                        ),),
                  ),
                ),
            ]
          ),     
        ],
      )
    );
  }
}