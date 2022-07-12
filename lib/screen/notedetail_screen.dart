import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/database.dart';
import '../model.dart';
import 'editnote_screen.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await MyDataBase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
          backgroundColor: Colors.white,
                bottomNavigationBar: BottomAppBar(
                  elevation: 0,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: ()async{
                            if (isLoading) return;

                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddEditNotePage(note: note),
                              ),
                            );
                            refreshNote();
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(child: Text("Edit",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            showMyCupertinoDialoge();
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(child: Text("Delete",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.all(12),
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    children: [
                      Text(
                        "${note.title}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        DateFormat.yMMMd().format(note.createdTime),
                        style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Divider(height: 1,color: Colors.black,thickness: 1,),
                      SizedBox(height: 8),
                      Text(
                        "${note.description}",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
      );

  showMyCupertinoDialoge() {
    return showCupertinoModalPopup(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Are You Sure You Want to Delete?"),
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
                  await MyDataBase.instance.delete(widget.noteId);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}