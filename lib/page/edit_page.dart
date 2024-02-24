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
    _titleController = TextEditingController(
      text: widget.nota.title,
    );
    _contentController = TextEditingController(
      text: widget.nota.content,
    );

    //inisialisasi nilai checklist item sesuai dengan jumlah item yang sudah ada
    _checklistItems = List<bool>.generate(
      widget.nota.content.split('\n').length,
        (index) => false,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Nota'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.nota.title = _titleController.text;
              widget.nota.content = _titleController.text + '\n' + _contentController.text;
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
              onPressed: () {
                setState(() {
                  _checklistItems.add(false);
                  widget.nota.content += '\n' + _addItemController.text;
                  _addItemController.clear();
                });
              },
              child: Text('Tambah item'),
            ),
          ],
        ),
      ),
    );
  }
}

class Nota {
  String title;
  String content;

  Nota(this.title, this.content);
}