import 'package:flutter/material.dart';

class NoteDetailPage extends StatefulWidget {
  final Nota nota;
  NoteDetailPage({
    Key? key,
    required this.nota,
  }) : super(key: key);

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late List<bool> _checklistItems;
  TextEditingController _addItemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.nota.title,);
    _contentController = TextEditingController(text: widget.nota.content,);

   // inisialisasi  nilai checklistitems hanya jika konten nota tidak kosong
    if (widget.nota.content.isNotEmpty) {
      _initializeChecklistItems();
    } else {
      _checklistItems = [];
    }
  }

  // fungsi  untuk inisialisasi checklistitems
  void _initializeChecklistItems() {
    _checklistItems = List<bool>.generate(
      _contentController.text.isNotEmpty ? _contentController.text.split('\n').length : 0,
        (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Nota'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteNote,
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveNote,
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
              if (_checklistItems.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _checklistItems.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(
                        widget.nota.content.split('\n')[index],
                        style: TextStyle(
                          decoration: _checklistItems[index]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      value: _checklistItems[index],
                      onChanged: (newValue) {
                        setState(() {
                          _checklistItems[index] = newValue!;
                        });
                      },
                    );
                },
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _addItemController,
                decoration: InputDecoration(labelText: 'Tambah Item'),
              ),
              ElevatedButton(
                onPressed: _addItem,
                child: Text('Tambah item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addItem() {
    setState(() {
      final newItem = _addItemController.text.trim();
      if (newItem.isNotEmpty) {
        _checklistItems.add(false);
        widget.nota.content += '\n' + newItem;
        _addItemController.clear();
      }
    });
  }

  void _saveNote() {
    setState(() {
      //simpan judul dan konten ke dalam objek nota
      widget.nota.title = _titleController.text;
      widget.nota.content = _contentController.text;

      // simpan status chekbox ke dalam konten nota
      List<String> lines = widget.nota.content.split('\n');
      for (int i = 0; i < _checklistItems.length && i < lines.length; i++) {
        if (_checklistItems[i]) {
          lines[i] = '[x]' + lines[i].substring(4);
        } else {
          lines[i] = '[ ]' + lines[i].substring(4);
        }
      }
      widget.nota.content = lines.join('\n');
    });
    Navigator.of(context).pop(widget.nota);
  }

  void _deleteNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus nota'),
          content: Text('Apakah anda yakin ingin menghapus nota?'),
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

}

class Nota {
  String title;
  String content;

  Nota(this.title, this.content);
}