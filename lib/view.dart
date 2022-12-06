import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fp29/update.dart';

import 'student.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List students = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  DatabaseReference starCountRef =
                      FirebaseDatabase.instance.ref('student');
                  starCountRef.onValue.listen((DatabaseEvent event) {
                    if (event.snapshot.value != null) {
                      Map data = event.snapshot.value as Map;
                      students.clear();
                      data.forEach((key, value) {
                        student s = student.fromjson(value, key);
                        students.add(s);
                      });
                      setState(() {});
                    }
                  });
                },
                child: Text("Tap Me")),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${students[index].name}"),
                      subtitle: Text("${students[index].number}"),
                      trailing: SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  DatabaseReference ref = FirebaseDatabase
                                      .instance
                                      .ref('student/${students[index].key}');
                                  print("${students[index].key}");
                                  students.removeAt(index);
                                  await ref.remove();
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete)),
                            IconButton(
                                onPressed: () async {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return update(
                                          students[index].key,
                                          students[index].name,
                                          students[index].number);
                                    },
                                  ));
                                },
                                icon: Icon(Icons.update)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
