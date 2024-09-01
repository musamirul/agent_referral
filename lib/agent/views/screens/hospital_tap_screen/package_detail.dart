import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PackageDetail extends StatelessWidget {
  const PackageDetail({super.key, required this.packageId});
  final String packageId;

  @override
  Widget build(BuildContext context) {
    CollectionReference package = FirebaseFirestore.instance.collection('package');

    return FutureBuilder<DocumentSnapshot>(
      future: package.doc(packageId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(child: Text("Document does not exist"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Center(
                  child: Text(
                    data['name'],
                    style: GoogleFonts.roboto(
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.w900,
                      color: Colors.brown.shade900,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.orange.shade400,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 570,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: data['image'],
                      imageBuilder: (context, imageProvider)  => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer(
                        duration: Duration(seconds: 2),
                        color: Colors.grey,
                        colorOpacity: 0.3,
                        enabled: true,
                        direction: ShimmerDirection.fromLTRB(),
                        child: Container(
                          color: Colors.grey[300],
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      data['description'],
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}