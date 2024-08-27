import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerWidget extends StatefulWidget {
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List _bannerImage = [];

  getBanners() {
    return _firestore
        .collection('package')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerImage.add(doc['image']);
        });
      });
    });
  }

  //call function when page gets loaded
  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                  spreadRadius: 5, // The spread of the shadow
                  blurRadius: 7, // The blur radius of the shadow
                  offset: Offset(0, 3), // Offset in the X and Y direction
                ),
              ],
          ),
          child: PageView.builder(
            itemCount: _bannerImage.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: _bannerImage[index],
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => Shimmer(
                    duration: Duration(seconds: 10),
                    interval: Duration(seconds: 10),
                    color: Colors.white,
                    colorOpacity: 0,
                    enabled: true,
                    direction: ShimmerDirection.fromLTRB(),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
              // child: Image.network(
              //   _bannerImage[index],
              //   fit: BoxFit.cover,
              // ));
            },
          )),
    );
  }
}
