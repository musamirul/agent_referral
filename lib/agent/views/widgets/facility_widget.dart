import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FacilityWidget extends StatelessWidget {
  FacilityWidget({super.key});

  final List<String> _categoryFacility = ['Diagnostic Imaging', 'Health Screening', 'Haemodialysis', 'Laboratory','Pharmacy', 'Patient Shuttle'];
  final List<String> _imageFacility = ['assets/images/diagnostic.jpg', 'assets/images/health.jpg', 'assets/images/dialysis.jpg','assets/images/laboratory.jpg', 'assets/images/pharmacy.jpg','assets/images/ambulance.jpg'];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('OUR FACILITIES    >', style: GoogleFonts.lato(fontSize: 13,fontWeight: FontWeight.w900,letterSpacing: 0, color: Colors.black87),),
          SizedBox(height: 5,),
          Container(
            height: 250,
            child: Row(
              children: [
                Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: _categoryFacility.length,itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Card(
                        elevation: 50,
                        shadowColor: Colors.transparent,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: 200,
                            height: 250,
                            child: Stack(
                              children: [
                                Image(
                                  image: AssetImage(_imageFacility[index]),
                                  fit: BoxFit.cover, // Adjusts the image to cover the container
                                  height: 250,
                                  width: 200,
                                ),
                                Positioned(
                                  bottom: 10, // Adjust this to position the text
                                  left: 10, // Adjust this to position the text
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(color: Colors.orange.shade200,borderRadius: BorderRadius.circular(5)),
                                      child: Text(' '+
                                        _categoryFacility[index]+'  ',
                                        style: TextStyle(
                                          fontSize: 14, // Adjust the size as needed
                                          fontWeight: FontWeight.bold, // Optional: Make the text bold
                                          color: Colors.black, // Text color, white to stand out against the image
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },))
              ],
            ),
          )
        ],
      ),
    );
  }
}
