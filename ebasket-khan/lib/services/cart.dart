


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebasket/model/cart.dart';
import 'package:ebasket/provider/cart.dart';

getFoods(FoodNotifier foodNotifier) async{
  QuerySnapshot snapshot = await Firestore.instance.collection('Add_to_Cart')
      .getDocuments();

  List<Food> _foodList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _foodList.add(food);
  }
  );

  foodNotifier.foodList = _foodList;
}