import 'package:flutter/material.dart';

class index_page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: new Container(
        color: Colors.indigoAccent[700],
        child: new Form(
        child: new Column(
        children: <Widget>[
          SizedBox(height: 350.0,),
          new Text('You need to sign in or create an account to continue',textAlign: TextAlign.center,style: TextStyle(fontSize:20.0,fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 300.0,),
          new SizedBox(
      width: 200.0,
      height: 50.0,
  child: new RaisedButton(
     child: new Text('Create an account',style: new TextStyle(fontSize:20.0),),
     color: Colors.white,
     shape: RoundedRectangleBorder(
     borderRadius: new BorderRadius.circular(25.0),
     ),
     onPressed: (){
       Navigator.pushNamed(context, '/a');
     },
    )
    ),
      ],
     )
    ),
        
          
      
      )
    );
  }
  
}