import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key});

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
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
        .collection('doctors')
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: CupertinoSearchTextField(
          controller: _searchController,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _resultList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_resultList[index]['name']),
            subtitle: Text(
              _resultList[index]['speciality'],
              style: TextStyle(fontSize: 12),
            ),
            trailing: Text(_resultList[index]['type']),
          );
        },
      ),
    );
  }
}