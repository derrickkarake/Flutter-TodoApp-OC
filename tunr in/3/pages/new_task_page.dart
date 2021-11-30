import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  @override
  _NewTaskPageState createState() {

    return _NewTaskPageState();
  }

}

class _NewTaskPageState extends State<NewTaskPage> {
final TextEditingController _controller = TextEditingController();
DateTime selectedDate;

  @override
  void dispose()
  {
    _controller.dispose();{
      super.dispose();
    }
  }

  Widget build(BuildContext context) {
    final today = DateTime.now();
    NavigatorArgs(){
      var userData = List(2);
      userData[0] = _controller.text;
      userData[1]= selectedDate;

      return userData;
    }
    //var userData = _controller.text, selectedDate;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [

          TextField(
            controller: _controller,
            minLines: 3,
            maxLines: null,
            decoration: InputDecoration(labelText: 'New task'),
          ),
         RaisedButton(
           onPressed: () => Navigator.of(context).pop(NavigatorArgs()),
           child:Text('Save'),
         ),

          RaisedButton(
            onPressed: () => showDatePicker(
                context: context,
                initialDate: today.add(const Duration(days:3)),
                firstDate: today,
                lastDate: today.add(const Duration(days:1000)),
            ).then((DateTime value) => setState(()=> selectedDate = value)),
            child: Text(selectedDate?.toString()?? 'Select Due Date'),

          ),

          // TODO 6: This can be found in home_page.dart
        ],
      ),
    );
  }
}
