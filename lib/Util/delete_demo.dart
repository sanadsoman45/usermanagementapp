import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stepperdemo/Databasedirectory/DatabaseHelper.dart';
import 'package:stepperdemo/Model/datamodel.dart';

class delete_demo extends StatefulWidget {
  @override
  _delete_demoState createState() => _delete_demoState();
}

class _delete_demoState extends State<delete_demo> {

  datamodel dm=new datamodel();
  DatabaseHelper _dbhelper;
  List<datamodel> _details=[];

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dbhelper=DatabaseHelper.instance;
    });
    _refreshdetailslist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _check_container(),
    );
  }

  _refreshdetailslist() async{
    List<datamodel> datam = await _dbhelper.fetchdetails();
    setState(() {
      _details=datam;
    });
    _check_container();
  }

  _check_container(){
    if(_details.length<=0){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Lottie.asset('assets/lottie/cloud.json',height: 250,width: 300)),
            Center(child: Text("NO USER DATA FOUND IN DATABASE TO BE DELETED",style: TextStyle(fontWeight: FontWeight.bold),)),
          ],
        ),
      );
    }
    else{
      return Container(
        margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: ListView.builder(
          itemBuilder: (context,index){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.grey,
                    leading: Icon(Icons.account_circle,size:40.0,),
                    title: Text(_details[index].f_name.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(_details[index].mob_num),
                    trailing: IconButton(
                      icon: Icon(Icons.delete,size: 40.0,),
                      onPressed: ()async{
                        await _dbhelper.deleteContact(_details[index].mob_num);
                        _refreshdetailslist();
                      },
                    ),
                  ),
                ),
                Divider(height: 5,),

              ],
            );
          },
          itemCount: _details.length,
        ),
      );
    }
  }



}

