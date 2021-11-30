import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../model/task.dart';
import '../utils/date_converter.dart';


class FirestoreBackend {
  static const _tasks = 'task';
  static const _description = 'description';
  static const _dueDate = 'due_date';
  static const _isCompleted = 'is_completed';

  static Future<List<Task>> getTasks() async {

    //await Firebase.initializeApp();

    var documents = await FirebaseFirestore.instance.collection(_tasks).get();

    List data = [];
    List ids = [];
    
    documents.docs.forEach((element) {
      ids.add(element.id);                                    
      data.add(element.data());
    });

   return List.generate(data.length, (index){
      return Task(
        description: data[index][_description],
        dueDate: (toDateTime(data[index][_dueDate])),
        id: ids[index]

      );
    }
    );
  }

  static Future<Task> insertTask(String description, DateTime dueDate) async {

    var result;
     Timestamp datetomil = Timestamp.fromDate(dueDate);  
    FirebaseFirestore.instance.collection(_tasks).add({

      "description" : "$description",
      "due_date" : datetomil,

    }).then((value){
        result = value.id; 
    });

    // TODO Insert (add) a document in the tasks collection and assigning the result to a variable.
    // TODO After it is inserted, return a Task where the id is the new document's documentID.

    return Task(description: description, dueDate: toDateTime(dueDate), id: result);
  }

  static Future<void> removeTask(Task task) {
    // TODO remove task and return the result
  return FirebaseFirestore.instance.collection(_tasks).doc(task.id).delete();  
  }

}
