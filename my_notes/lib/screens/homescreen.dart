import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_notes/database/databaseHelper.dart';
import 'package:my_notes/screens/addNote.dart';
import 'package:my_notes/screens/updateNote.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List> alldata;

  Future<List> getdata() async {
    DatabaseHelper obj = new DatabaseHelper();
    var data = obj.getNotes();
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }

  DeleteDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you Sure ?"),
            content: Text("Do you want to delete your note ?"),
            actions: [
              MaterialButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(child: Text("Yes"), onPressed: () {})
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAD Notes"),
      ),
      backgroundColor: Color.fromARGB(255, 234, 234, 234),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: alldata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length <= 0) {
                return Center(
                  child: Text("No data found"),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: ListTile(
                        onTap: (){
                          var id = snapshot.data[index]["PID"].toString();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateNote(upid: id,)));
                        },
                        trailing: IconButton(
                            onPressed: () {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Are you Sure ?"),
                                      content: Text(
                                          "Do you want to delete your note ?"),
                                      actions: [
                                        MaterialButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        MaterialButton(
                                            child: Text("Yes"),
                                            onPressed: () {
                                              DatabaseHelper obj =
                                                  new DatabaseHelper();
                                              var pid =
                                                  snapshot.data[index]["PID"];
                                              var id = obj.deleteproducts(pid);
                                              setState(() {
                                                alldata = getdata();
                                              });
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        isThreeLine: true,
                        tileColor: Colors.white,
                        title: Text(
                          snapshot.data[index]["TITLE"].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(snapshot.data[index]["DESC"].toString(),
                            maxLines: 3),
                      ),
                    );
                  },
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
