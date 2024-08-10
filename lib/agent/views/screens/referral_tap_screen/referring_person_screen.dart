// import 'package:agent_referral/provider/referral_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ReferringPersonScreen extends StatefulWidget {
//   const ReferringPersonScreen({super.key});
//
//   @override
//   State<ReferringPersonScreen> createState() => _ReferringPersonScreenState();
// }
//
// class _ReferringPersonScreenState extends State<ReferringPersonScreen> with AutomaticKeepAliveClientMixin{
//
//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
//
//   List<String> _referralOption = ['Patient','Relatives','Agent','Doctor','Other'];
//   String? referral;
//   List<String> _locationOption = ['Home','Work Place', 'Health Care Centre','Organization'];
//   String? location;
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               DropdownButtonFormField(hint: Text('Select Referring Person'),items: _referralOption.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem(value: value,child: Text(value));
//               }).toList(), onChanged: (value) {
//                 _referralProvider.getFormData(referralPerson: value);
//               },),
//               TextFormField(
//                 validator: (value) {
//                   if(value!.isEmpty){
//                     return 'Enter Referral Name';
//                   }else{
//                     return null;
//                   }
//                 },
//                 onChanged: (value) {
//                   _referralProvider.getFormData(referralName: value);
//                 },
//                 decoration: InputDecoration(label: Text('Name')),
//               ),
//               DropdownButtonFormField(hint: Text('Select Address Location'),items: _locationOption.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem(child: Text(value),value: value,);
//               }).toList(), onChanged: (value) {
//                 _referralProvider.getFormData(referralLocation: value);
//               },),
//               SizedBox(height: 20,),
//               TextFormField(
//                 validator: (value) {
//                   if(value!.isEmpty){
//                     return 'Enter Home Address';
//                   }else{
//                     return null;
//                   }
//                 },
//                 onChanged: (value) {
//                   _referralProvider.getFormData(referralAddress: value);
//                 },
//                 maxLength: 800,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   labelText: 'Home Address',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)
//                   )
//                 ),
//               ),
//               TextFormField(
//                 validator: (value) {
//                   if(value!.isEmpty){
//                     return 'Enter Email Address';
//                   }else{
//                     return null;
//                   }
//                 },
//                 onChanged: (value) {
//                   _referralProvider.getFormData(referralEmail: value);
//                 },
//                 decoration: InputDecoration(label: Text('Email')),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
