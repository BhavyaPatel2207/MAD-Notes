import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_notes/database/databaseHelper.dart';
import 'package:my_notes/screens/homescreen.dart';
import 'package:sqflite/sqflite.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var _form = new GlobalKey<FormState>();
  TextEditingController _title = new TextEditingController();
  TextEditingController _desc = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //     Navigator.of(context)
        //         .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        //   },
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.white,
        //   ),
        // ),
        // titleSpacing: 10,
        title: Text("Add your note"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 9, right: 9),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return "This field is required";
                      }
                    },
                    controller: _title,
                    decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _desc,
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (_form.currentState.validate()) {
                        var title = _title.text.toString();
                        var desc = _desc.text.toString();
        
                        DatabaseHelper obj = new DatabaseHelper();
                        var status = await obj.addNote(title, desc);
                        var id = status.toString();
        
                        print(id);
        
                        setState(() {
                          _title.text = "";
                          _desc.text = "";
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context) => HomeScreen()));
                      }
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
