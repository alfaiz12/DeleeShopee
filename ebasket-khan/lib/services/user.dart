import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebasket/model/cart_item.dart';
import 'package:ebasket/model/user.dart';
import 'package:ebasket/screen/home_product.dart';

class UserServices {
  //collection of users
  String collection = "users";
  //collection of orders
  String collections = "orders";
  //collection of products
  String collectionss = "user_cat";
  Firestore _firestore = Firestore.instance;

  // create users function
  void createUsers(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  // update data function
  void updateUserData(Map<String, dynamic> values){
    _firestore.collection(collection).document(values["id"]).updateData(values);
  }

  //adding to cart

  void addToCart({String userId,Map cartItem}){
    _firestore.collection(collection).document(userId).updateData({
      "cart":FieldValue.arrayUnion([cartItem])
    });
  }

  void updateToCart({String userId,List cartItem}){
    _firestore.collection(collection).document(userId).updateData({
      "cart":cartItem
    });
  }
 //updating status of cancel order from here
  void updateToCartorder({String orderId}){
    _firestore.collection(collections).document(orderId).updateData({
      "status":"-100"
    });
  }

  //upating stock of each products from here
  void updateToProductStock({String productId,String stock}){
    _firestore.collection(collectionss).document(productId).updateData({
      "stock":stock
    });
  }

  void removeFromCart({String userId,Map cartItem}){
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayRemove([cartItem])
    });
  }

  // fetch user data
  Future<UserModel>  getUserById(String id)=>_firestore.collection(collection).document(id).get().then((doc){
    return UserModel.fromsnapshot(doc);
  });

}
