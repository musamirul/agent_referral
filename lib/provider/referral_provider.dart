import 'package:flutter/material.dart';

class ReferralProvider extends ChangeNotifier {
  //this map will store the product related information
  Map<String, dynamic> referralData = {};

  //this method will be used to update the product related fields
  getFormData({
    String? referralPerson,
    String? referralName,
    String? referralLocation,
    String? referralAddress,
    String? referralEmail,
    String? patientName,
    String? patientIc,
    String? patientNationality,
    String? patientAddress,
    String? patientPhone,
    String? patientAge,
    String? patientGender,
    String? patientPayment,
    String? patientIns,
    String? patientInsNumber,
    String? patientPolicyPeriod,
    String? patientBed,
    String? patientComplaints,
    String? patientDateAccident,
    String? patientTimeAccident,
  }) {
    //ensure that only non null values were added
    if(referralPerson!=null){
      referralData['referralPerson'] = referralPerson;
    }
    if(referralName!=null){
      referralData['referralName'] = referralName;
    }
    if(referralLocation!=null){
      referralData['referralLocation'] = referralLocation;
    }
    if(referralAddress!=null){
      referralData['referralAddress'] = referralAddress;
    }
    if(referralEmail!=null){
      referralData['referralEmail'] = referralEmail;
    }
    if(patientName!=null){
      referralData['patientName'] = patientName;
    }
    if(patientIc !=null){
      referralData['patientIc'] = patientIc;
    }
    if(patientNationality!=null){
      referralData['patientNationality'] = patientNationality;
    }
    if(patientAddress!=null){
      referralData['patientAddress'] = patientAddress;
    }
    if(patientPhone!=null){
      referralData['patientPhone'] = patientPhone;
    }
    if(patientAge!=null){
      referralData['patientAge'] = patientAge;
    }
    if(patientGender!=null){
      referralData['patientGender'] = patientGender;
    }
    if(patientPayment!=null){
      referralData['patientPayment'] = patientPayment;
    }
    if(patientIns!=null){
      referralData['patientIns'] = patientIns;
    }
    if(patientInsNumber!=null){
      referralData['patientInsNumber'] = patientInsNumber;
    }
    if(patientPolicyPeriod!=null){
      referralData['patientPolicyPeriod'] = patientPolicyPeriod;
    }
    if(patientBed!=null){
      referralData['patientBed'] = patientBed;
    }
    if(patientComplaints!=null){
      referralData['patientComplaints'] = patientComplaints;
    }
    if(patientDateAccident!=null){
      referralData['patientDateAccident'] = patientDateAccident;
    }
    if(patientTimeAccident!=null){
      referralData['patientTimeAccident'] = patientTimeAccident;
    }
    notifyListeners();
  }

  clearData(){
    referralData.clear();
    notifyListeners();
  }
}

