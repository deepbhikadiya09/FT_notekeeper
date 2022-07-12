import 'package:flutter/material.dart';


import '../common/text_field.dart';
import '../database/database.dart';

import '../model.dart';


class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
    ),
    body: GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),

            child: Form(
              key: _formKey,
              child: Column(

                children: [
                  NoteFormWidget(
                    title: title,
                    description: description,
                    onChangedTitle: (title) => setState(() => this.title = title),
                    onChangedDescription: (description) =>
                        setState(() => this.description = description),
                  ),
                  buildButton(),

                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Container(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(


          onPrimary: Colors.white,
          primary: isFormValid ? Colors.black : Colors.black26
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save',style: TextStyle(fontSize: 20),),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      title: title,
      description: description,
    );

    await MyDataBase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );

    await MyDataBase.instance.create(note);
  }
}