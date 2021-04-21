import 'package:flutter/material.dart';
import 'package:stepperdemo/Databasedirectory/DatabaseHelper.dart';
import 'package:stepperdemo/Model/datamodel.dart';
String mobile_number;
class displaydata extends StatefulWidget {
  var mob_num;
  @override
  _displaydataState createState() => _displaydataState();
  displaydata({Key key, @required this.mob_num}) : super(key: key);
}

class _displaydataState extends State<displaydata> {
  datamodel dm=new datamodel();
  DatabaseHelper _dbhelper;
  var x;

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dbhelper=DatabaseHelper.instance;
    });
    get_details_mobnum(widget.mob_num);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            height: 500,
            width: 550,
            decoration: BoxDecoration(
              border: Border.all(color:Colors.black,width: 1.2)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("First Name:",style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${x.f_name}\n "),
                Text("Last Name:",style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${x.l_name}\n"),
                Text("Address:",style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${x.address} \n"),
                Text("Pincode:",style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${x.pincode} \n"),
                Text("Mobile Number:",style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${x.mob_num} \n"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  get_details_mobnum(String mob_num) async {
    var x1 = await _dbhelper.getmob_num(mob_num);
    x1.submitdetails_data();
    setState(() {
      x=x1;
    });
  }

}
