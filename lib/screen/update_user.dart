import 'package:flutter/material.dart';
import 'package:sqflitedemo/utils/database.dart';
import '../model/user.dart';

class UpdateUser extends StatefulWidget {
  final User user;
  UpdateUser({this.user});
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  final sized = SizedBox(height: 10.0);
  final dbhelper = DataBaseHelper.dataBaseHelper;
  var _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    name.text = widget.user.getNAme;
    email.text = widget.user.getEmail;
    password.text = widget.user.getPassword;
    super.initState();
  }

  Widget _textField(String label, IconData iconData,
      TextEditingController textEditingController) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        prefixIcon: Icon(
          iconData,
          color: Colors.grey,
        ),
      ),
    );
  }

  update() async {
    if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty) {
      _showSnackBAr("Please Enter Data", Colors.red);
    } else {
      User user =
          User.withId(widget.user.getId, email.text, name.text, password.text);
      int ans = await dbhelper.update(user);
      if (ans != null) Navigator.pop(context, true);
    }
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
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("Update User"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListView(
            padding: const EdgeInsets.all(10.0),
            shrinkWrap: true,
            // primary: false,
            children: <Widget>[
              _textField("Name", Icons.person_outline, name),
              sized,
              _textField("Email", Icons.email, email),
              sized,
              _textField("Password", Icons.remove_red_eye, password),
              sized,
              sized,
              RaisedButton(
                onPressed: update,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                elevation: 7.0,
                splashColor: Colors.orange,
                child: const Text(
                  "Update",
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.black54,
                textColor: Colors.white,
                shape: StadiumBorder(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
