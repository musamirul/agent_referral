import 'package:agent_referral/agent/views/screens/hospital_tap_screen/package_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({super.key});

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  List<dynamic> _allResults = [];
  List<dynamic> _resultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getClientStream();
    _searchController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    List<dynamic> showResults = [];
    if (_searchController.text != "") {
      for (var clientSnapshot in _allResults) {
        var name = clientSnapshot['name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('package')
        .orderBy('name')
        .get();
    setState(() {
      _allResults = data.docs;
      searchResultList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseStorage _storage = FirebaseStorage.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CupertinoSearchTextField(
          controller: _searchController,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _resultList.length,
        itemBuilder: (context, index) {
          return index == null? Center(
            child: Text('No Package Available'),
          ): Dismissible(
            confirmDismiss: (direction) async{
              return await showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text('Confirm'),
                  content: Text('Are you sure you wish to delete this package'),
                  actions: [
                    ElevatedButton(onPressed: () {
                      Navigator.of(context).pop(true);
                    }, child: Text("Delete")),
                    ElevatedButton(onPressed: () {
                      Navigator.of(context).pop(false);
                    }, child: Text("Cancel"))
                  ],
                );
              },);
            },
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(Icons.delete,size: 40,color: Colors.white,),
            ),
            key: ValueKey<int>(index),
            onDismissed: (direction){
              setState(() async {
                _firestore.collection('package').doc(_resultList[index]['packageId']).delete();
                final desertRef = _storage.ref().child("packageImages/"+_resultList[index]['packageId']);
                // Delete the file
                await desertRef.delete();
              });
            },
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return PackageDetail(packageId: _resultList[index]['packageId']);
                },));
              },
              child: ListTile(
                title: Text(_resultList[index]['name']),
                subtitle: Text(
                  _resultList[index]['description'],
                  style: TextStyle(fontSize: 12),maxLines: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
