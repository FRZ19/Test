import 'package:app1/page/edit_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Nota> notes = [];

  void _addNote() {
    TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Nota'),
          content: TextField(
            controller: titleController,
            autofocus: true,
            decoration: InputDecoration(labelText: 'Judul nota'),
          ),
          actions: <Widget>[
            TextButton(
             child: Text('Batal'),
             onPressed: () {
               Navigator.of(context).pop();
             },
            ),
            TextButton(
              child: Text('Tambah'),
              onPressed: () {
                setState(() {
                  notes.add(Nota(titleController.text, ''));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  void _editNote(Nota nota) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailPage(nota: nota),
      ),
    ).then((updateNota) {
      if (updateNota != null) {
        setState(() {
          nota = updateNota;
        });
      }
    });
  }

  void _deleteNote(Nota nota) {
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
                setState(() {
                  notes.remove(nota);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nota App'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notes[index].title),
            onTap: () => _editNote(notes[index]),
            onLongPress: () => _deleteNote(notes[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Tambah Nota',
        child: Icon(Icons.add),
      ),
    );
  }
}
