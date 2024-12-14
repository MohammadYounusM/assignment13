import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(FileApp());

class FileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FileScreen(),
    );
  }
}

class FileScreen extends StatefulWidget {
  @override
  _FileScreenState createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  TextEditingController _controller = TextEditingController();
  String _content = "";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes.txt');
  }

  Future<void> _saveToFile() async {
    final file = await _localFile;
    await file.writeAsString(_controller.text);
    setState(() => _content = "Data Saved!");
  }

  Future<void> _readFromFile() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      setState(() => _content = contents);
    } catch (e) {
      setState(() => _content = "Error reading file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Read/Write'),
        leading: GestureDetector(child: Icon(Icons.arrow_back),
        onTap: (){
          Navigator.pop(context);
          setState((){});
        },
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Text',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _saveToFile, child: Text('Save')),
                ElevatedButton(onPressed: _readFromFile, child: Text('Read')),
              ],
            ),
            SizedBox(height: 30),
            Text(
              _content,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
