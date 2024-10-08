import 'package:agent_referral/agent/views/screens/hospital_tap_screen/package_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PackageInfoScreen extends StatefulWidget {
  const PackageInfoScreen({super.key});

  @override
  State<PackageInfoScreen> createState() => _PackageInfoScreenState();
}

class _PackageInfoScreenState extends State<PackageInfoScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _packageImage = [];
  List<String> _packageId = [];

  @override
  void initState() {
    super.initState();
    getImageStream();
  }

  Future<void> getImageStream() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('package').get();
      List<String> imageUrls = [];
      List<String> ids = [];

      for (var doc in querySnapshot.docs) {
        imageUrls.add(doc['image'] as String);
        ids.add(doc['packageId'] as String);
      }

      setState(() {
        _packageImage = imageUrls;
        _packageId = ids;
      });
    } catch (e) {
      print("Error fetching images: $e");
      // Handle errors accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Package List',
            style: GoogleFonts.roboto(
              letterSpacing: 0.9,
              fontWeight: FontWeight.w900,
              color: Colors.brown.shade900,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: _packageImage.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PackageDetail(packageId: _packageId[index]),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: _packageImage[index],
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                placeholder: (context, url) => Shimmer(
                  duration: Duration(seconds: 2),
                  color: Colors.grey,
                  colorOpacity: 0.2,
                  enabled: true,
                  direction: ShimmerDirection.fromLTRB(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            );
          },
        ),
      ),
    );
  }
}