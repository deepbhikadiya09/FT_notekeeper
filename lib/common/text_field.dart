import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final String? title;
  final String? description;

  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.black,
                initialValue: title,
                decoration: InputDecoration(
                  isDense: true,
                  focusColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Title',
                ),
                validator: (title) {
                  if(title != null && title.isEmpty){
                    return "Title can't be empty";
                  }else if(title!.length>40){
                    return "Please enter title less then 40 words";
                  }
                },
                onChanged: onChangedTitle,
              ),
              SizedBox(height: 10,),
              TextFormField(
                textInputAction: TextInputAction.done,

                maxLines: 5,
                cursorColor: Colors.black,
                initialValue: description,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.black54),
                ),
                validator: (title) => title != null && title.isEmpty
                    ? 'The description cannot be empty'
                    : null,
                onChanged: onChangedDescription,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      );
}
