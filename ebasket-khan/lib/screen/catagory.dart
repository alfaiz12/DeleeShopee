import 'package:ebasket/screen/productCatagory.dart';
import 'package:flutter/material.dart';

class horizontal_list extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: 101.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            catagory(
              image_caption: 'fruits',
              image_location: 'images/ff.png',
            ),
            catagory(
              image_caption: 'vegetables',
              image_location: 'images/vv.png',
            ),
            catagory(
              image_caption: 'dry fruits',
              image_location: 'images/almond.png',
            ),
            catagory(
              image_caption: 'oil',
              image_location: 'images/oil.jpg',
            ),
            catagory(
              image_caption: 'cerealas',
              image_location: 'images/cerelas.jpg',
            ),
            catagory(
              image_caption: 'pulses',
              image_location: 'images/pulses.jpg',
            ),
            catagory(
              image_caption: 'spices',
              image_location: 'images/spices.jpg',
            ),
            catagory(
              image_caption: 'dairy products',
              image_location: 'images/milk.jpg',
            ),
            catagory(
              image_caption: 'Bakery products',
              image_location: 'images/bakery.jpg',
            ),
            catagory(
              image_caption: 'eggs & chicken',
              image_location: 'images/egs.jpg',
            ),
            catagory(
              image_caption: 'mahila gruhudyog products',
              image_location: 'images/mahila.jpg',
            ),
            catagory(
              image_caption: 'terrace gardening',
              image_location: 'images/plant.png',
            ),
          ],
        ),
      ),
    );
  }
}

class catagory extends StatelessWidget {
  final String image_location;
  final String image_caption;

  catagory({
    this.image_caption,
    this.image_location,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context){
              return catagoryProduct(CatagoryType: image_caption,);
            }
          ));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(image_location,
              width: 100.0,
              height: 60.0,),
            subtitle: Container(
              width: 25.0,
              alignment: Alignment.topCenter,
              child: Text(
                  image_caption
              ),
            ),
          ),
        ),
      ),
    );
  }
}