import 'package:flutter/material.dart';
import 'package:stepperdemo/Util/Stepper1.dart';
import 'package:stepperdemo/Util/delete_demo.dart';
import 'package:stepperdemo/Util/editmodule.dart';
import 'package:stepperdemo/Util/listviewdemo.dart';


class Stepperdemo extends StatefulWidget {
  @override
  _StepperdemoState createState() => _StepperdemoState();
}

class _StepperdemoState extends State<Stepperdemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("USER MANAGEMENT APP"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Image.asset("assets/images/flutterpic.png",height: 250,width: 400,),
            InkWell(
                onTap: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>listview()))
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("View records"),
                    ),
                    Spacer(),
                    Icon(Icons.navigate_next_rounded),
                  ],
                )
            ),
            Divider(thickness: 2.3,),
            InkWell(
              onTap: ()=>{
                Navigator.push(context, MaterialPageRoute(builder: (context)=>delete_demo()))
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.delete,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Delete records"),
                  ),
                  Spacer(),
                  Icon(Icons.navigate_next_rounded),
                ],
              ),
            ),
            Divider(thickness: 2.3,),
            InkWell(
              onTap: ()=>{Navigator.push(context, MaterialPageRoute(builder: (context)=>editmodule()))},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.edit,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Edit Details"),
                  ),
                  Spacer(),
                  Icon(Icons.navigate_next_rounded),
                ],
              ),
            ),
            Divider(thickness: 2.3,),
          ],
        ),
      ),
      body: Stepper1(),
    );
  }
}
