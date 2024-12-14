import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(NoteApp());

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Notes',
      theme: ThemeData(primarySwatch: Colors.green),
      home: NoteScreen(),
    );
  }
}

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Database? _db;
  List<Map<String, dynamic>> _notes = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  Future<void> _initDb() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) => db.execute('CREATE TABLE notes (id INTEGER PRIMARY KEY, content TEXT)'),
      version: 1,
    );
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final data = await _db?.query('notes');
    setState(() => _notes = data ?? []);
  }

  Future<void> _addNote() async {
    await _db?.insert('notes', {'content': _controller.text});
    _controller.clear();
    _loadNotes();
  }

  Future<void> _deleteNote(int id) async {
    await _db?.delete('notes', where: 'id = ?', whereArgs: [id]);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQLite Notes'), 
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: (){
          setState(() {
            Navigator.pop(context);
          });
        },
      ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter your note'),
            ),
          ),
          ElevatedButton(onPressed: _addNote, child: Text('Add Note')),
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(_notes[index]['content']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteNote(_notes[index]['id']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
