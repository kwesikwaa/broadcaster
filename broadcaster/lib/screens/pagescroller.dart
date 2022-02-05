import 'package:broadcaster/Models/toyItem.dart';
import 'package:flutter/material.dart';

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
  
  _listen(){
    setState(() {
      curindex = _pagecontroler.page;
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
                  child: OutlinedButton(
                    style: ButtonStyle(
                      // foregroundColor: Colors.amberAccent,
                    ),
                    onPressed: (){},
                    child: Text(
                      widget.categories[index],
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),
                  ),
                ),)
            ),),
          AspectRatio(
            aspectRatio: 0.7,
            child: PageView.builder(
              // onPageChanged: (page)=>setState((){curindex = page;}),
              physics: const BouncingScrollPhysics(),
              itemCount: toys.length,
              controller: _pagecontroler,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 90),
                  child: Transform.translate(
                    offset: const Offset(0,0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.elasticIn,
                      margin: EdgeInsets.only(top: index==curindex?10:30,bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)
                        ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [Column(
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
                        // Positioned(
                        //       right: MediaQuery.of(context).size.width,
                        //       bottom: -25,
                        //       child: Container(
                        //         height: 50,
                        //         width: 50,
                        //         decoration: BoxDecoration(
                        //           color: Colors.blue,
                        //           borderRadius: BorderRadius.circular(50)
                        //         ),),
                        //     )
                        ]
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          const Text('Asay you say', style: TextStyle(color: Colors.amber),)  
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomitems,
        currentIndex: (curindex>2? 2: curindex).toInt(),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedFontSize: 8,
        onTap:(v)=>setState((){
          curindex = v.toDouble();
          // _pagecontroler.jumpToPage(v);
          _pagecontroler.animateToPage(v, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
          }),
      ),
    );
  }
}