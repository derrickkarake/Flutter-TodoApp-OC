import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../services/my_controller.dart';
import '../model/task.dart';
import '../services/auth.dart';
import '../pages/opening_page.dart';
import '../pages/new_task_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  List<Task> tasks = [];

  @override
  void initState() {
   super.initState();

    _getTasks();

  }

  Future<void> _getTasks() async {
 //  await MyController.initialize():

    MyController.getTasks().then((value) {
      setState(() {
        tasks = value;
         });
      });
    }

    Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(child: SafeArea(
        child: Column(children: [ListTile(title: Text('Log out'),
          onTap: () {
            Auth.signOut();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => OpeningPage()),
                    (route) => false);
          },

        ),
        ],),),),


          body:  ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                final task = tasks.removeAt(oldIndex ~/ 2);
                if (newIndex >= oldIndex) {
                  tasks.insert(newIndex ~/ 2 - 1, task);
                } else {
                  tasks.insert(newIndex, task);
                }
              });
            },
            children: tasks
                .map(_toWidget)
                .map((e) => [e, Divider(key: UniqueKey())])
                .expand((e) => e)
                .toList(),
          ),

       /*
          ListView.separated(
              // ignore: missing_return
              itemBuilder:(BuildContext context, int index) {
              //   return _toWidget(tasks[index]);
                var t = _toWidget(tasks[index]);

             return Dismissible(
                 onDismissed: (direction){
                   MyController.deleteTask(tasks[index]);
                   },
               secondaryBackground: Container(
                 child: Align(
                   alignment: Alignment.centerRight,
                   child:Icon(Icons.delete,color: Colors.white,),

                 ),
                   color: Colors.red,

               ),
               background: Container(),
               child: _toWidget(tasks[index]),
               key: ValueKey(t),
               direction: DismissDirection.endToStart,
             );
              },
              separatorBuilder: (buildContext, index) {
                return Divider();
                },
              itemCount:tasks.length,
          ),

        */

          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                  onPressed:(){
                    FirebaseMessaging.instance.getToken().then(print);
                        Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => NewTaskPage())).then( (result){
                            MyController.addTask(result[0], result[1]);
                          });
                        },
                tooltip: 'New Task',
                child:Icon(Icons.add),
              )
            ],

          ),

      appBar: AppBar(
        title: Text('Todo'),
        actions:[
        if ((tasks.any((task) => task.isCompleted == true)) == true )
            IconButton(
              icon:Icon(Icons.delete),
              onPressed: () {
                MyController.deleteTask(
                    tasks.firstWhere((tasks) => tasks.isCompleted == true));
              },
            )
        ],
      ),
    );
  }

  Widget _toWidget(Task t) {
    return

         CheckboxListTile(
             value: t.isCompleted,
             key:ValueKey(t),
             title: Text(t.description),
             onChanged: (bool value) => setState(() {
               if (t.isCompleted == false){
                 t.isCompleted = true;
               } else if ( t.isCompleted == true){
                 t.isCompleted = false;
               }

             }),//
           subtitle: Text(t.dueDate?.toString() ?? ''),
           secondary: Icon(Icons.drag_handle, color: Colors.black),
        );
  }
}
