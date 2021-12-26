import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const NAME = "Name";
  static const PICTURE = "image";
  static const PRICE = "price";
  static const QUANTITY = "qty";
  static const CATEGORY = "category";
  static const ID = "id";
  static const DESCRIPTION = "discription";
  static const STOCK ="stock";
  static const QUANS = "quantity";
  static const SALE = "sale";
  //private vaiable
  String _name;
  String _picture;
  String _description;
  int _quantity;
  int _price;
  int _totalprice;
  String _category;
  String _id;
  String _stock;
  String _quans;
  String _sale;

  //getters to accces
  String get name => _name;
  String get picture => _picture;
  int get quantity => _quantity;
  int get price => _price;
  int get totalpriced => _totalprice;
  String get category => _category;
  String get id => _id;
  String get description => _description;
  String get stock => _stock;
  String get quans => _quans;
  String get sale => _sale;
//constructor
  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _picture = snapshot.data[PICTURE];
    _price = (int.parse(snapshot.data[PRICE]));
    _quantity=snapshot.data[QUANTITY];
    _category=snapshot.data[CATEGORY];
    _description=snapshot.data[DESCRIPTION];
    _id=snapshot.data[ID];
    _totalprice=int.parse(snapshot.data[PRICE])*snapshot.data[QUANTITY];
    _stock = snapshot.data[STOCK];
    _quans = snapshot.data[QUANS];
    _sale = snapshot.data[SALE];
  }
}
