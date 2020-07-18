import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screen/update_user.dart';
import '../model/user.dart';
import '../utils/database.dart';

class AllUser extends StatefulWidget {
  @override
  _AllUserState createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  final dbhelper = DataBaseHelper.dataBaseHelper;
  List<User> _list = List<User>();
  var _key = GlobalKey<ScaffoldState>();
  fetchAllUser() async {
    await dbhelper.initDb();
    _list = await dbhelper.fetchAllUser();
    setState(() {});
  }

  @override
  void initState() {
    fetchAllUser();
    super.initState();
  }

  _dialog(int msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are Sure You Want To Delete $msg Record"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    int result = await dbhelper.deleteUser(msg);
                    if (result != null)
                      _showSnackBAr(
                          "$msg Record Deleted Successfully", Colors.green);
                    Navigator.pop(context);
                    fetchAllUser();
                  },
                  child: const Text("Yes"),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("No"),
                )
              ],
            ));
  }

  void _showSnackBAr(String msg, Color color) {
    _key.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(title: const Text("All User")),
      key: _key,
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (ctx, i) => Card(
                margin: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.orange,
                  elevation: 10.0,
                  margin: const EdgeInsets.all(0.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(5.0),
                    leading: FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      heroTag: "bt$i",
                      backgroundColor: Colors.black38,
                      child: Text(_list[i].getId.toString()),
                    ),
                    title: Text(_list[i].getNAme),
                    subtitle: Text(_list[i].getEmail),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FloatingActionButton(
                          backgroundColor: Colors.green,
                          mini: true,
                          heroTag: "btn$i",
                          onPressed: () async {
                            bool ans = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateUser(
                                    user: _list[i],
                                  ),
                                ));
                            if (ans != null) {
                              fetchAllUser();
                            }
                          },
                          child: Icon(
                            Icons.edit,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        FloatingActionButton(
                          backgroundColor: Colors.red,
                          mini: true,
                          heroTag: "btnbtn$i",
                          onPressed: () => _dialog(_list[i].getId),
                          child: Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
