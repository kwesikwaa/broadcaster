import 'package:broadcaster/toyshop/models/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Homestore extends HookConsumerWidget{
  const Homestore({Key  key}):super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('buildyy..');
    final category = ref.watch(categoryprovider);
    final future = ref.watch(futureProvider.select((name) => name));
    final size = MediaQuery.of(context).size;
    
    // final prov = ref.watch(statprov);
    // final boo = ref.watch(booltins);

    final some = ref.watch(countcontrol);
    
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.read(countcontrol.notifier).add();
          // ref.read(booltins.notifier).update((state) => !state);
          // prov.update((state) => state +3);
          // ref.read(statprov.notifier).update((state) => state +2);
        },
        child: const Text('DO'),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: 50,),
          Text(some.toString()),
          SizedBox(height: 50,),
          Text('$category'),
          Expanded(
            child: future.when(
              loading: ()=> const CircularProgressIndicator(), 
              error: (error, stack)=> Text('$error'),
              data: (data)=> GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                  children: List.generate(
                    20, (index) => 
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.cyan,
                        borderRadius:  BorderRadius.horizontal( )
                      ),
                      
                    )
                  ),
                )      
                ,
             ),
          ),
        ],) ,
      ),
    );
  }
}