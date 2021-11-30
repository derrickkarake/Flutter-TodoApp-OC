import 'package:flutter/material.dart';
import '../services/my_controller.dart';
import '../model/task.dart';
import '../pages/new_task_page.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// TODO 0: Run the code as is and make sure it is working correctly on your device.

class _HomePageState extends State<HomePage> {
  // TODO 1: create a local, private variable and assign it the result of getTasks from MyController.

  var tasks = MyController.getTasks();
  // These tasks will be shown using the build() method and updated when tapping on the CheckBox
  // You will have to import '../services/my_controller.dart'.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 3: add a ListView.separated() as the body of the scaffold
          body: ListView.separated(
              // ignore: missing_return
              itemBuilder:(BuildContext context, int index) {

               return _toWidget(tasks[index]); // figure out how to send the text over
              },
              separatorBuilder: (buildContext, index) {
                return Divider();
              },
              itemCount:tasks.length,

          ),


      // In ListView.separated, there are 3 required fields: itemBuilder, separatorBuilder, and itemCount
      // This will look like 'body: ListView.separated(...)'
      // itemCount is tasks.length
      // for separatorBuilder, return Divider();
      // for itemBuilder use _toWidget to convert the index's task to a widget.
      // If you can't figure out the syntax, use Alt+Enter to show a list of arguments

      // TODO 4: This can be found in new_task_page.dart

      appBar: AppBar(
        title: Text('Todo'),
        // TODO 6: Now add a way to view the NewTaskPage.
        actions:<Widget>[
          IconButton(
              icon:Icon(Icons.add),
              onPressed:() {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => NewTaskPage()));
              }
          ),

        ],
        // add an action to the app bar as a IconButton()
        // the button's icon will be Icon(Icons.add)
        // the button's onPressed will be  () =>  Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewTaskPage()))
        // import new_task_page.dart using Alt+Enter

      ),
    );
  }

  Widget _toWidget(Task t) {
    // TODO 2: return a ListTile()
    // The ListTile's leading will be a Checkbox whose value is t.isCompleted.
    // Set the ListTile's onChanged to : (value) {} for now.
    // Assign the ListTile's title to be a Text() using the task's description
    return

         ListTile(
          leading: Checkbox( value: t.isCompleted, onChanged: (bool value) {}),
             title: Text(t.description),
        );


  }
}
