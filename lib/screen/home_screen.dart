import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../common/card.dart';
import '../database/database.dart';
import '../model.dart';
import 'editnote_screen.dart';
import 'notedetail_screen.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  final user = FirebaseAuth.instance.currentUser!;

  // @override
  // void dispose() {
  //   MyDataBase.instance.close();
  //   super.dispose();
  // }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await MyDataBase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(

          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "${user.email}",
            style: TextStyle(fontSize: 24),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    showMyCupertinoDialoge();
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        body: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : notes.isEmpty
                    ? Text(
                        'No Notes',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      )
                    : buildNotes(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          reverse: true,
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              child: GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NoteDetailPage(noteId: note.id!),
                    ),
                  );
                  refreshNotes();
                },
                child: NoteCardWidget(
                  note: note,
                  index: index,
                ),
              ),
            );
          }),
    );
  }

  showMyCupertinoDialoge() {
    return showCupertinoModalPopup(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Are You Sure You Want to LogOut?"),
            actions: [
              CupertinoDialogAction(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                textStyle: TextStyle(color: Colors.red),
                child: Text("Yes"),
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
