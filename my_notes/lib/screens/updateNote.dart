import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_notes/database/databaseHelper.dart';
import 'package:my_notes/screens/homescreen.dart';

class UpdateNote extends StatefulWidget {
  var upid = "";
  UpdateNote({this.upid});
  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController _title = new TextEditingController();
  TextEditingController _desc = new TextEditingController();
  var _form = new GlobalKey<FormState>();

  getNote() async {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.singleNote(widget.upid);
    setState(() {
      _title.text = data[0]["TITLE"].toString();
      _desc.text = data[0]["DESC"].toString();
    });
  }

  @override
  void initState() {
    getNote();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Note"),
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
                  TextField(
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
                  TextField(
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
                        var id = obj.updateNote(title, desc,widget.upid);
        
                        print(id);
        
                        setState(() {
                          _title.text = "";
                          _desc.text = "";
                        });
        
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
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
