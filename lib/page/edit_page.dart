import 'package:flutter/material.dart';

class NoteDetailPage extends StatefulWidget {
  final Nota nota;
  NoteDetailPage({
    super.key,
    required this.nota,
  });

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.nota.title,
    );
    _contentController = TextEditingController(
      text: widget.nota.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Nota'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteNote(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.nota.title = _titleController.text;
              widget.nota.content = _contentController.text;
              Navigator.of(context).pop(widget.nota);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul Nota'),
            ),
            SizedBox(height: 16.0,),
            TextField(
              controller: _contentController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: 'Isi Nota'),
            )
          ],
        ),
      ),
    );
  }
}

void _deleteNote(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Nota'),
          content: Text('Apakah Anda yakin ingin menghapus nota ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(null);
              },
            ),
          ],
        );
      }
  );
}

class Nota {
  String title;
  String content;

  Nota(this.title, this.content);
}