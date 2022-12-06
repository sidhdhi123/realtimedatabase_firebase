import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fp29/view.dart';

class index extends StatefulWidget {
  const index({Key? key}) : super(key: key);

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  // FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireBase/RealTime Database"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: TextField(
              decoration: InputDecoration(hintText: "Name"),
              controller: t1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: TextField(
              decoration: InputDecoration(hintText: "Number"),
              controller: t2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: ElevatedButton(
                onPressed: () async {
                  DatabaseReference ref =
                      FirebaseDatabase.instance.ref('student');

                  await ref.push().set({
                    "name": t1.text,
                    "number": t2.text,
                  }).then((value) {
                    t1.clear();
                    t2.clear();
                    print("Data Entered");
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return view();
                      },
                    ));
                  });
                },
                child: Text("Save Data")),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return view();
                    },
                  ));
                },
                child: Text("View Data")),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
