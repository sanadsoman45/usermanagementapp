import 'package:flutter/material.dart';
import 'package:stepperdemo/Databasedirectory/DatabaseHelper.dart';
import 'package:stepperdemo/Model/datamodel.dart';

class editrecord extends StatefulWidget {
  var mob_num;
  @override
  _editrecordState createState() => _editrecordState();
  editrecord({Key key, @required this.mob_num}) : super(key: key);
}

class _editrecordState extends State<editrecord> {
  datamodel dm=new datamodel();
  DatabaseHelper _dbhelper;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var x;
  List<datamodel> _details=[];
  RegExp fnameregex= new RegExp(r"^[a-zA-Z]+$");
  RegExp mobile_num=new RegExp(r"^[0-9]+$");

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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 1.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text("PERSONAL DETAILS",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    initialValue: x.f_name,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    onSaved: (newValue) => dm.f_name=newValue,
                    validator: (value) {
                      value=value.trim();
                      if(value.isEmpty || value.length<1){
                        return "First Name cannot be empty";
                      }
                      else if(!fnameregex.hasMatch(value)){
                        return "Please enter first name in valid format";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Enter First Name",
                        icon: const Icon(Icons.person),
                        labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
                  ),
                  TextFormField(
                    initialValue: x.l_name,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    onSaved: (newValue) => dm.l_name=newValue,
                    validator: (value) {
                      value=value.trim();
                      if(value.isEmpty || value.length<1){
                        return "Last Name cannot be empty";
                      }
                      else if(!fnameregex.hasMatch(value)){
                        return "Please enter Last name in valid format";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Enter Last Name",
                        icon: const Icon(Icons.person),
                        labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
                  ),
                  TextFormField(
                    initialValue: x.address,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      value=value.trim();
                      if(value.length<1 || value.isEmpty){
                        return "Address cannot be empty";
                      }
                      return null;
                    },
                    onSaved: (newValue) => dm.address=newValue,
                    decoration: InputDecoration(
                        labelText: "Enter Address",
                        labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
                        icon: Icon(Icons.home_work_outlined)
                    ),

                  ),
                  TextFormField(
                    initialValue: x.pincode,
                    keyboardType: TextInputType.numberWithOptions(decimal:false),
                    validator: (value) {
                      value=value.trim();
                      if(value.length<1 || value.isEmpty){
                        return "Pincode cannot be empty";
                      }
                      else if(!mobile_num.hasMatch(value)){
                        return "Only Numbers Allowed";
                      }
                      return null;
                    },
                    onSaved: (newValue) => dm.pincode=newValue,
                    decoration: InputDecoration(
                        labelText: "Enter Pincode",
                        labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
                        icon: Icon(Icons.local_post_office)
                    ),

                  ),
                  TextFormField(
                    initialValue: x.mob_num,
                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                    validator: (value) {
                      value=value.trim();
                      debugPrint("before$value");
                      if(value.length<1 || value.isEmpty){
                        return "Mobile Number cannot be empty";
                      }
                      else if(!mobile_num.hasMatch(value)){
                        return "Only Numbers Allowed";
                      }
                      else if(value.length!=10){
                        return "Mobile Number Should be of length 10";
                      }
                      return null;
                    },
                    onSaved: (newValue) => dm.mob_num=newValue,
                    decoration: InputDecoration(
                        labelText: "Enter Mobile Number",
                        labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
                        icon: Icon(Icons.call)
                    ),

                  ),
                  InkWell(
                    onTap: submitdetails,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Text("Submit Edited Details",)),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color:Colors.black,width: 1.2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
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


  submitdetails() async{
    final FormState formState = _formKey.currentState;
    if(!formState.validate()){
      debugPrint("Please Fill in remaining fields too..");
    }
    else{
      formState.save();
      await _dbhelper.updateContact(dm,widget.mob_num);
      AlertDialog alert=AlertDialog(
        title: Text("Details"),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              Text("First Name is:${dm.f_name}"),
              Text("Last Name is:${dm.l_name}"),
              Text("Address is:${dm.address}"),
              Text("Pincode is:${dm.pincode}"),
              Text("Mobile number is:${dm.mob_num}"),
            ],
          ),
        ),
        actions: [
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
            formState.reset();
          }, child: Text("OK"))
        ],
      );

      showDialog(context: context,
          builder: (BuildContext context){
            return alert;
          });
    }
  }

}
