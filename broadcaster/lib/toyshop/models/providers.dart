import 'package:broadcaster/toyshop/models/toymodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/*
  provider
  futureprovider
  streamprovider
  stateprovider
  statenotifierprovider
  modifiers... provider.autoDispose.. provider.family
*/
/*
 in situations where specific property is need
 there is no need calling the entire boject
 String name = ref.watch(userProvider.select((user)=>user.name))
*/
//for sync
//provider.. a service class/computed property(filtered list)
final categoryprovider = Provider<int>((ref)=>2022);
final anotherprovider = Provider((ref){
  return 'Asey wosop';
});
final subprovider = Provider((ref){
  final category = ref.watch(categoryprovider);
  return category/5;
});

//for async  //use with ref.watch for auto update realtime
//returns a future of any type..a resul from an api call
final futureProvider = FutureProvider<Toy>((ref) async{
  return  Future.delayed(const Duration(seconds:20),()=>
    Toy(
      name: 'Otherside',
      description: 'description here',
      artist: 'artist name',
      price: 30.5,
      thumbnail: 'ocation here',
      images: ['first photo','second photo', 'third photo']
    )
  );
});

//  stream providerm
final streamy = StreamProvider<int>((ref){
  return Stream.periodic(const Duration(seconds: 5),(number){
    if(number < 5){
      return number + 5;
    }
    else{
      return 5;
    }
  });
});

// statenotifierprovider
final someprovider = StateNotifierProvider<Stateclass,int>((ref){
  return Stateclass(ref);
});

class Stateclass extends StateNotifier<int>{
  final Ref ref;
  Stateclass(this.ref): super(0);

  increment(){
    final fromotherprovider = ref.read(subprovider);
    fromotherprovider.round();
  }
}

//stateprovider is a simplication of statenotifierprovider. avoids writing statenofier class
// for very simple use-cases
//usually enum, texfield string, boolean, number for pagination or age
//not to be used for complex situation
final statprov = StateProvider((ref)=> 10);  //call increaste later by state.state++
final booltins = StateProvider((ref)=> false);

class Todo{
  final bool isCompleted;
  final String description;

  Todo(this.description, this.isCompleted);
}

class TodosNotifier extends StateNotifier<List<Todo>>{
  TodosNotifier(): super([]);

  addTodo(Todo todo){
    state = [...state, todo];
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref){
  return TodosNotifier();
});

//now provider can be used to cache filter
final completedtodoprovider = Provider<List<Todo>>((ref){
  final todos = ref.watch(todosProvider);
  return todos.where((todo) => todo.isCompleted).toList();
});

//

class Product{
  Product(this.name, this.price);

  final String name;
  final double price;
}

final _products = [
  Product('moko', 0.5),
  Product('salmon', 10),
  Product('onion', 3),
];

final productsprovider = Provider<List<Product>>((ref){
  return _products;
});

enum ProductSortType{
  name,price
}

final productsortprovider = StateProvider<ProductSortType>((ref){
  return ProductSortType.name;  //defualt
});

//sorting the list
// final productsProvider = Provider<List<Product>>((ref){
//   final sortType = ref.watch(productsortprovider);
//   switch(sortType){
//     case ProductSortType.name:
//       return _products.sort((a,b)=> a.name.compareTo(b.name));
//     case ProductSortType.price:
//       return _products.sort((a,b)=>a.price.compareTo(b.price));
//   }
// });

//think abouyt this

final dbprovider = Provider<Db>((ref)=>Db());

class Db{
  Future<String> getUserData(){
    return Future.delayed(const Duration(seconds: 5), ()=> 'Hospital');
  }
}

final userProvider = FutureProvider<String>((ref){
  return ref.read(dbprovider).getUserData();
});



final countcontrol = StateNotifierProvider<CounterNotifieer,int>((ref)=>CounterNotifieer());
//tadas watched it with counctonrol.state.tostring()
//and on callback use context.read(countcontrol).add()

class CounterNotifieer extends StateNotifier<int>{
  CounterNotifieer(): super(5);

  void add(){
    state = state+1;
  }
  void substract(){
    state = state-1;
  }
}

