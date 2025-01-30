import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PdpaScreen extends StatelessWidget {
  const PdpaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Text(
              'NOTICE OF PERSONAL DATA PROTECTION ACT 2010',
              style: GoogleFonts.lato(
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text('KPJ Klang Specialist Hospital is subject to '
                  'the personal data protection principles under the '
                  'Personal Data Protection Act 2010 '
                  '(hereafter referred to as PDPA) with effect from 15 November 2013, which regulates the processing of '
                  'personal data in commercial transactions. The terms "personal data", '
                  '"processing" and "commercial transactions" shall have the meaning '
                  'provided in the PDPA.',style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                  "It is obligatory that you "
                      "supply us with your personal data. "
                      "If you fail to supply us with such personal "
                      "data, we may not be able to process and/or disclose "
                      "your data for the purposes as provided "
                      "in item C) below",style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "This Personal Data Notice applies to any person whose personal data is being processed by KPJ Klang Specialist Hospital.",style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "We wish to inform you how your personal data is being processed by and on behalf of KPJ Klang Specialist Hospital.",style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "A) Source of the Personal Data",style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "Your personal data is collected from various sources, including information you have provided us, information from third parties and information in the public domain.",style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "B) Description of the Personal Data",style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "Your personal data processed by us may include, where relevant:- name, date of birth, "
                    "identity card or passport, name of employer/company, home and office address, telephone/handphone number, faximile number, email address, "
                    "occupation, age, gender, marital status, weight, height, photos, race,"
                    " nationality, religion, family and/or next of kin information, "
                    "medical checkup result, medical record, Medical Report No. (MRN),"
                    " medical report, diagnosis, personal health information, "
                    "criminal history, investigation result, insurance details and any "
                    "other personal data required for the purposes set out in item C) "
                    "below.",style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "C) Purposes of the Personal Data",style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "Your personal data may be processed for the following purposes, where relevant :",style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "1. for medical and healthcare services,\n"
                    "2. to facilitate the patients personal needs i.e. extension of stay for health tourists,\n"
                    "3. to establish and manage medical records and medical reports,\n"
                    "4. to facilitate payment process relating to the patients,\n"
                    "5. to institute debt recovery proceedings against defaulters,\n"
                    "6. to report the personal data to the relevant authorities and/or third parties under the governing laws relevant to the healthcare industry,\n"
                    "7. to share the personal data with KPJ Healthcare Berhad and its related companies as defined in the Companies Act 1965,to conduct research, analysis and improvement,\n"
                    "8. to market and advertise products and services,\n"
                    "9. to administer and respond to request, queries, complaints and legal issues,for education and training and \n"
                    "10 .for any other purpose that is incidental or in furtherance to the above purposes.\n",style: GoogleFonts.lato(fontSize: 10),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "D) Disclosure of the Personal Data",style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "Your personal data may be disclosed to the following parties, where relevant :",style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "Healthcare professional (as defined in PDPA), KPJ Healthcare Berhad and its related companies (as defined under CA 1965), Government agencies, Local authorities, non government agencies, Paying and insurance agent, Debt collection authorities and agencies, Financial institutions, Legal firms, Auditors, Vendor/Contractor, Other private and public hospitals, Other Healthcare providers, Training provider, Family and next of kin, to such parties as may be required by law, court, regulator or legal process to disclose, to such parties as may be permitted under the laws of Malaysia and any other person which KPJ Klang SPECIALIST HOSPITAL may deem necessary.",style: GoogleFonts.lato(fontSize: 10),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "E) Access and Update the Personal Data",style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "We shall do our best to ensure that the personal data we hold about you is accurate, complete, not misleading and up-to-date. If there are any changes to your personal data or if you believe that the personal data we have about you is inaccurate, incomplete, misleading or not up-to-date, please contact us so that we may take steps to update your personal data.",style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "You have the right to access your personal data. If you would like to request access to your personal data, please contact us. We recommend that your request for access to your personal data held by Damansara Specialist Hospital 2 be made in writing. We may also take steps to verify your identity before fulfilling your request for access to your personal data.",style: GoogleFonts.lato(fontSize: 12),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "In accordance with the PDPA :",style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "i. Depending on the information requested, we may charge a fee as stipulated in the First Schedule (Regulation 2) of Personal Data Protection [Fees] Regulations 2013 for processing your request for access; and",style: GoogleFonts.lato(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
              child: Text(
                "ii. We may refuse to comply with your request to access or make a correction in accordance with PDPA.",style: GoogleFonts.lato(fontSize: 12),),
            ),


          ]),
        ),
      ),
    );
  }
}
