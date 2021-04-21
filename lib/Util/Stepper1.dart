import 'package:flutter/material.dart';
import 'package:stepperdemo/Databasedirectory/DatabaseHelper.dart';

import 'package:stepperdemo/Model/datamodel.dart';
datamodel dm=new datamodel();
class Stepper1 extends StatefulWidget {
  @override
  _Stepper1State createState() => _Stepper1State();
}

class _Stepper1State extends State<Stepper1> {
  int currStep = 0;
  DatabaseHelper _dbhelper;
  RegExp fnameregex= new RegExp(r"^[a-zA-Z]+$");
  RegExp mobile_num=new RegExp(r"^[0-9]+$");
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dbhelper=DatabaseHelper.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Stepper(
              type: StepperType.vertical,
              currentStep: currStep,
              onStepTapped: (value) => tapped(value),
              onStepCancel: stepcancel,
              onStepContinue: stepcontinue,
              steps:[
                Step(
                    title: Text("Basic Details"),
                    isActive:(currStep>=0)?true:false,
                    content: Form(
                      key: formKeys[0],
                      child: Column(
                        children: [
                          TextFormField(
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
                        ],
                      ),
                    )
                ),
                Step(
                    title: Text("Address"),
                    isActive: (currStep>=1)?true:false,
                    content: Form(
                      key: formKeys[1],
                      child: Column(
                        children: [
                          TextFormField(
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
                        ],
                      ),
                    )
                ),
                Step(
                    title: Text("Contact details"),
                    isActive:(currStep==2)?true:false,
                    content: Form(
                      key: formKeys[2],
                      child: Column(
                        children: [
                          TextFormField(
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
                              // else if(get_value_record(value)!="empty"){
                              //   dm.submitdetails_data();
                              //   debugPrint("${_dbhelper.getmob_num(value).toString()}");
                              //   debugPrint("$value");
                              //   return "Mobile Number already in use.";
                              // }
                              return null;
                            },
                            onSaved: (newValue) => dm.mob_num=newValue,
                            decoration: InputDecoration(
                                labelText: "Enter Mobile Number",
                                labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
                                icon: Icon(Icons.call)
                            ),

                          ),

                        ],
                      ),
                    )
                )
              ],
            ),
            InkWell(
              onTap: submitdetails,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 100,
                  child: Center(child: Text("Submit Details")),
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
    );
  }

  tapped(int value) {
    setState(() {
      currStep=value;
    });
  }



  stepcancel(){
    (currStep>0)?setState(()=>currStep--):null;
  }

  get_value_record(String value) async {
    await _dbhelper.getmob_num(value);
  }
  
  submitdetails() async{
    final FormState formState = _formKey.currentState;
    if(!(formState.validate() && formKeys[0].currentState.validate() && formKeys[1].currentState.validate() && formKeys[2].currentState.validate())){
      debugPrint("Please Fill in remaining fields too..");
    }
    else{

      formKeys[0].currentState.save();
      formKeys[1].currentState.save();
      formKeys[2].currentState.save();
      formState.save();
      await _dbhelper.insertcontact(dm);
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
            setState(()=>currStep=0);
            formKeys[0].currentState.reset();
            formKeys[1].currentState.reset();
            formKeys[2].currentState.reset();
          }, child: Text("OK"))
        ],
      );

      showDialog(context: context,
          builder: (BuildContext context){
            return alert;
          });
    }
  }



  void stepcontinue() {
    final FormState formState = _formKey.currentState;
    if((formState.validate() && formKeys[currStep].currentState.validate())){
      setState(() {
        (currStep<2)?currStep++:null;
      });
    }

  }
}

