import 'package:agent_referral/agent/views/screens/hospital_tap_screen/package_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PackageInfoScreen extends StatefulWidget {
  const PackageInfoScreen({super.key});

  @override
  State<PackageInfoScreen> createState() => _PackageInfoScreenState();
}

class _PackageInfoScreenState extends State<PackageInfoScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List _packageImage = [];
  List _packageId = [];

  getImageStream() async {
    return _firestore.collection('package').get().then(
          (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach(
              (doc) {
            setState(() {
              _packageImage.add(doc['image']);
              _packageId.add(doc['packageId']);
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getImageStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package List'),
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
            return index==null? Center(
              child: Text('No Package Available'),
            ):InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return PackageDetail(packageId: _packageId[index]);
                },));

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
                  duration: Duration(seconds: 2), //Default value
                  color: Colors.grey, //Default value
                  colorOpacity: 0, //Default value
                  enabled: true, //Default value
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
