import 'package:agent_referral/provider/referral_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:provider/provider.dart'; // Make sure to import the provider package
 // Import your ReferralProvider class

class UploadReferralScreen extends StatefulWidget {
  @override
  _UploadReferralScreenState createState() => _UploadReferralScreenState();
}

class _UploadReferralScreenState extends State<UploadReferralScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _fileExtensionController = TextEditingController();
  String? _fileName;
  List<PlatformFile>? _paths;
  List<File> _files = [];
  List<String> _fileUrlList = [];
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _fileExtensionController.addListener(() {
      _extension = _fileExtensionController.text;
    });
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        compressionQuality: 30,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))?.files;

      if (_paths != null) {
        _files = _paths!.map((file) => File(file.path!)).toList();
      }
    } on PlatformException catch (e) {
      _logException('Unsupported operation: ${e.toString()}');
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  Future<void> _uploadFiles() async {
    if (_files.isEmpty) {
      _showMessage('No files selected to upload');
      return;
    }

    final ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context, listen: false);

    EasyLoading.show(status: 'Saving Document');
    try {
      for (var file in _files) {
        Reference ref = _storage.ref().child('patientDocument').child(Uuid().v4());

        await ref.putFile(file).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            setState(() {
              _fileUrlList.add(value);
            });
          });
        });
      }
      setState(() {
        _referralProvider.getFormData(fileUrlList: _fileUrlList);
        EasyLoading.dismiss();
      });
      _showMessage('Files uploaded successfully!');
    } catch (e) {
      EasyLoading.dismiss();
      _logException('Failed to upload files: ${e.toString()}');
    }
  }

  void _logException(String message) {
    print(message);
    _showMessage(message);
  }

  void _showMessage(String message) {
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _resetState() {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _files = [];
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Upload Referral'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Configuration',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20.0),
                Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 400.0),
                      child: SwitchListTile.adaptive(
                        title: Text('Pick multiple files'),
                        onChanged: (bool value) => setState(() => _multiPick = value),
                        value: _multiPick,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Divider(),
                SizedBox(height: 20.0),
                Text(
                  'Actions',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: FloatingActionButton.extended(
                          onPressed: _pickFiles,
                          label: Text(_multiPick ? 'Pick files' : 'Pick file'),
                          icon: const Icon(Icons.description),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: FloatingActionButton.extended(
                          onPressed: _uploadFiles,
                          label: const Text('Save'),
                          icon: const Icon(Icons.save),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 20.0),
                Text(
                  'File Picker Result',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Builder(
                  builder: (BuildContext context) => _isLoading
                      ? Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  )
                      : _userAborted
                      ? Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: 300,
                            child: ListTile(
                              leading: Icon(Icons.error_outline),
                              contentPadding: EdgeInsets.symmetric(vertical: 40.0),
                              title: const Text('User has aborted the dialog'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      : _directoryPath != null
                      ? ListTile(
                    title: const Text('Directory path'),
                    subtitle: Text(_directoryPath!),
                  )
                      : _paths != null
                      ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: Scrollbar(
                      child: ListView.separated(
                        itemCount: _paths?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final bool isMultiPath = _paths != null && _paths!.isNotEmpty;
                          final String name = 'File $index: ' +
                              (isMultiPath
                                  ? _paths!.map((e) => e.name).toList()[index]
                                  : _fileName ?? '...');
                          final path = kIsWeb
                              ? null
                              : _paths!.map((e) => e.path).toList()[index].toString();

                          return ListTile(
                            title: Text(name),
                            subtitle: Text(path ?? ''),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                      ),
                    ),
                  )
                      : const SizedBox(),
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}