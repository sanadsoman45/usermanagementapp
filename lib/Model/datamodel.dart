import 'package:flutter/material.dart';

class datamodel{
  String f_name;
  String l_name;
  String address;
  String pincode;
  String mob_num;

  datamodel([this.f_name, this.l_name, this.address, this.pincode, this.mob_num]);

  datamodel.frommap(Map<String,dynamic> map){
    f_name=map["f_name"];
    l_name=map["l_name"];
    address=map["address"];
    pincode=map["pincode"];
    mob_num=map["mob_num"];
    submitdetails_data();
  }

  Map<String,dynamic> tomap(){
    var map=<String,dynamic>{'f_name':f_name,'l_name':l_name,'address':address,'pincode':pincode,'mob_num':mob_num};
    return map;
  }

  void submitdetails_data() {
    debugPrint("First Name is:${f_name}");
    debugPrint("Last Name is:${l_name}");
    debugPrint("Mobile number is:${mob_num}");
    debugPrint("Address is:${address}");
    debugPrint("Pincode is:${pincode}");
  }

}