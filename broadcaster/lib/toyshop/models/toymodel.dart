import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<Catergories> toyscategory =[
  Catergories(name: 'character', icon: const Icon(Icons.access_alarms)),
  Catergories(name: 'vfx', icon: const Icon(Icons.add_alarm)),
  Catergories(name: 'props', icon: const Icon(Icons.one_k_sharp)),
  Catergories(name: 'environ', icon: const Icon(Icons.videocam_sharp))
];
class Catergories{
  String name;
  Icon icon;

  Catergories({@required this.name, @required this.icon});
}
class Toy{
  String name;
  String description;
  String artist;
  double price;
  String thumbnail;
  List<String> images;

  Toy({ 
    this.name,
    this.description,
    this.artist,
    this.images,
    this.price,
    this.thumbnail
  });

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'name':name,
      'description':description,
      'artist':artist,
      'price':price,
      'thumbnail':thumbnail,
      'images':images
    };
  }

  factory Toy.fromjson(Map<String, dynamic> json){
    if(json==null){
      return null;
    }
    return Toy(
      name:json["name"],
      description:json["descritption"],
      artist:json["artist"],
      price:json["price"],
      thumbnail:json["thumbnail"],
      images:json["images"]
    );
  }
}