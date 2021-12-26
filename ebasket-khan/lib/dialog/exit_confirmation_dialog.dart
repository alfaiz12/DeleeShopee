import 'package:ebasket/helpers/screen_navigation.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/auth.dart';
import 'package:ebasket/screen/myorderpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExitConfirmation extends StatelessWidget {
  final id;
  ExitConfirmation(this.id);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }
  _buildChild(BuildContext context)=>Container(
    height: 340,
   decoration: BoxDecoration(
     color: Colors.green,
     shape: BoxShape.rectangle,
     borderRadius: BorderRadius.all(Radius.circular(11.0))
   ),
   child: Column(
     children: <Widget>[
       Container(
         child: Padding(
           padding: const EdgeInsets.all(12.0),
           child: Image.asset('images/sad.png',height: 120,width: 120,),
         ),
         width: double.infinity,
         decoration: BoxDecoration(
             color: Colors.white,
             shape: BoxShape.rectangle,
             borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
         ),
       ),
       SizedBox(height: 24.0,),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text('Are you sure you want to cancel order?',style: TextStyle(fontSize:19,color: Colors.white,fontWeight: FontWeight.bold),),
       ),
       SizedBox(height: 8.0,),
      /* Padding(
         padding: const EdgeInsets.only(right: 16,left: 16),
         child: Text('If cancel button is clicked by mistake then press no to continue',style: TextStyle(fontSize:19,color: Colors.white),textAlign: TextAlign.center,),
       ),*/
       SizedBox(height: 24.0,),
       Row(
         mainAxisSize: MainAxisSize.min,
         children: <Widget>[
           FlatButton(onPressed: (){
             Navigator.of(context).pop();
           },child: Text('No'),textColor:Colors.white,),
           SizedBox(width: 8.0,),
           RaisedButton(onPressed: (){
             final user = Provider.of<AuthProvider>(context,listen: false);
             final app = Provider.of<AppProvider>(context,listen: false);
             app.changeIsLoading();
             print(id);
             user.updateToCardorder(id);
             user.reloadOrderModel();
             app.changeIsLoading();
            Navigator.pop(context);
            Navigator.pop(context);
           },child: Text('Yes'),color: Colors.white,textColor: Colors.green,)
         ],
       )
     ],
   ),
  );
}
