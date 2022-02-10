import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ToyShop extends StatefulWidget {
 ToyShop({Key key}) : super(key: key);

  @override
  State<ToyShop> createState() => _ToyShopState();
}

class _ToyShopState extends State<ToyShop> {
  final ScrollController _scrolctrl = ScrollController();
  bool fold = false;
  double offset = 0;

  @override
  void initState() {
    super.initState();
    _scrolctrl.addListener(() {
      setState(() {
        // fold = _scrolctrl.offset>0;
        if(_scrolctrl.position.userScrollDirection == ScrollDirection.idle){fold = false;}
        else{fold = true;}
      });
    });
  }
  @override
  
  void dispose() {
    super.dispose();
    _scrolctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    // print(_scrolctrl.offset);
    return Scaffold(
      body: Container(
        color: Colors.white,
        // height: h,
        child: Column(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: fold?0:1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                alignment: Alignment.topCenter,
                height: fold?0:h*0.3,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:Row(
                    children: 
                      List.generate(8, (index) => Container(height: h*0.3, width: 150, 
                        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 6),
                        decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)), 
                        child: Text(index.toString()*200,),)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _scrolctrl,
                itemCount: 15,
                itemBuilder: (context, index){
                  print(fold);
                  print(_scrolctrl.offset);
                  return AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    heightFactor: fold?0.7:1,
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: (Text(index.toString())),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10 ),
                      decoration: BoxDecoration(
                        color: Colors.blue, 
                        boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0,-5), blurRadius: .1, spreadRadius:.1)],
                        borderRadius: BorderRadius.circular(8)),),
                  );
                }))
          ],
        ),
      ),
    );
  }
}