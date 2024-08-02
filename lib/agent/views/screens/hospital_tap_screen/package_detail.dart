import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                data['name'],
                style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: CachedNetworkImage(
              imageUrl: data['image'],
              imageBuilder: (context, imageProvider)  => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Shimmer(
                duration: Duration(seconds: 2), // Default value
                color: Colors.grey, // Default value
                colorOpacity: 0.3, // Default value
                enabled: true, // Default value
                direction: ShimmerDirection.fromLTRB(),
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}