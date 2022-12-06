import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fp29/view.dart';

class update extends StatefulWidget {
  String? key1, name, number;

  update(this.key1, this.name, this.number);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    t1.text = widget.name!;
    t2.text = widget.number!;
    setState(() {

    });
  }

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
                      FirebaseDatabase.instance.ref('student/${widget.key1}');
                  await ref.update({
                    "name": t1.text,
                    "number": t2.text,
                  }).then((value) {
                    t1.clear();
                    t2.clear();
                    print("Data Updated");
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return view();
                      },
                    ));
                  });
                },
                child: Text("Save Data")),
          ),
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
