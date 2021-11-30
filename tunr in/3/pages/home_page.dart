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

  //var tasks = MyController.getTasks();
  List<Task> tasks = [];
  String savedText;
  // These tasks will be shown using the build() method and updated when tapping on the CheckBox
  // You will have to import '../services/my_controller.dart'.
  @override
  void initState() {
    super.initState();
    _getTasks();

  }

  Future<void> _getTasks() async {
    await MyController.initialize();

    MyController.getTasks().then((value) {
      setState(() {
        tasks = value;
         });
      });
    }


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

      appBar: AppBar(
        title: Text('Todo'),
        leading:
          IconButton(
              icon:Icon(Icons.delete),
              onPressed: (){

                MyController.deleteTask(tasks.firstWhere((tasks)=> tasks.isCompleted == true));

               /*
                setState(() {
                  tasks.removeWhere((tasks) => tasks.isCompleted == true);

                });

                */
          }),

        actions:<Widget>[

          IconButton(
              icon:Icon(Icons.add),
              onPressed:() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => NewTaskPage())).then( (result){


                  MyController.addTask(result[0], result[1]);

                    // return _toWidget(result);
             /*
                  setState(() {
                    tasks.add(Task(description: result));
                  });

              */



                }
                );
              }
          ),

        ],

      ),
    );
  }

  Widget _toWidget(Task t) {
    return

         CheckboxListTile(
             value: t.isCompleted,
             title: Text(t.description),
             onChanged: (bool value) => setState(() {
               if (t.isCompleted == false){
                 t.isCompleted = true;
               } else if ( t.isCompleted == true){
                 t.isCompleted = false;
               }

             }),//
           subtitle: Text(t.dueDate?.toString() ?? ''),
        );


  }
}
