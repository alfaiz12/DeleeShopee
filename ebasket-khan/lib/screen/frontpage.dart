/*import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/helpers/style.dart';
import 'package:ebasket/screen/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class uildcard extends StatefulWidget {
  final name;
  final status;
  final image;
  final category;
  final id;
  uildcard(this.name, this.status, this.image, this.category, this.id);

  @override
  _uildcardState createState() => _uildcardState();
}

class _uildcardState extends State<uildcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      elevation: 7.0,
      child: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          Stack(
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.image
                          )
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40.0),
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: red,
                      //color: widget.status == 'Away' ? Colors.amber : Colors.green,
                      border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2.0
                      )
                  ),
                )
              ]),
          SizedBox(height: 8.0),
          Text(
            widget.name,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            "\u20B9"+widget.status.toString(),
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.grey
            ),
          ),
          SizedBox(height: 15.0),
          Expanded(
              child: GestureDetector(
                onTap: (){
                  changeScreen(context, ProductDetail(widget.name, widget.status, widget.image, widget.category, widget.id,widget.));

                },
                child: Container(
                  width: 175.0,
                  decoration: BoxDecoration(
                    color: widget.status == 'Away' ? Colors.grey: Colors.green,
                    borderRadius: BorderRadius.only
                      (
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)
                    ),
                  ),

                  child: Center(
                    child: Text('Add',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Quicksand'
                      ),
                    ),
                  ),

                ),
              )
          )
        ],
      ),
//margin: cardIndex.isEven? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0):EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0)
    );;
  }
}*/
