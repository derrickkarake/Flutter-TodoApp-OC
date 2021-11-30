import 'package:flutter/material.dart';

class NewTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          // TODO 4: Add a TextField() so users can type in the TextField.

          TextField(
            minLines: 3,
            maxLines: null,
            decoration: InputDecoration(labelText: 'New task'),
          ),
          // In the TextField, Set minLines to 3 and maxLines to null. This will show that it is a multiline inputfield.
          // To tell the user what to add here, provide a hint using "decoration: InputDecoration(labelText: 'New task'),"

          // TODO 5: Add a RaisedButton here to allow the users to save their task.

         RaisedButton(
           onPressed: () => Navigator.of(context).pop(),
           child:Text('Save'),
         ),

          // In this assignment, you will not save the task. You will instead just go back to the home page.
          // The button's child should be a text widget saying 'Save'
          // For onPressed, use () => Navigator.of(context).pop()

          // TODO 6: This can be found in home_page.dart
        ],
      ),
    );
  }
}
