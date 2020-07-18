import 'package:flutter/material.dart';
import 'alluser.dart';
import '../utils/database.dart';
import '../model/user.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoginScreen = true;
  final dbHelper = DataBaseHelper.dataBaseHelper;
  var _key = GlobalKey<ScaffoldState>();
  _changeLogInScreen() {
    setState(() {
      _isLoginScreen = true;
      _emailController.text = "";
      _passwordController.text = "";
    });
  }

  _changeRegisterScreen() {
    _isLoginScreen = false;
    _emailController.text = "";
    _passwordController.text = "";
    setState(() {});
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

  void _showSnackBAr(String msg, Color color) {
    _key.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    ));
  }

  registerUser() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showSnackBAr("Enter Data", Colors.red);
    } else {
      User user = User(_emailController.text.toString(),
          _nameController.text.toString(), _passwordController.text);
      int id = await dbHelper.insert(user.toMap());
      print(id);
      _showSnackBAr("Register Successfully", Colors.green);
    }
    // print("$id is inserted");
  }

  login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBAr("Enter Data", Colors.red);
    } else {
      var result = await dbHelper.login(_emailController.text.toString(),
          _passwordController.text.toString());
      if (result.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllUser(),
          ),
        );
      } else {
        _showSnackBAr("Enter valid email and password", Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: const Color(0xffecf4fa),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(),
              Container(
                height: 200.0,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                color: const Color(0xff2b518f),
                child: Text(
                  _isLoginScreen
                      ? "SIGN IN TO CONTINUE"
                      : "SIGN UP WITH CONTINUE",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: const EdgeInsets.only(left: 20.0),
              ),
              _isLoginScreen
                  ? Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: const Color(0xffffffff),
                      shadowColor: Colors.green,
                      margin: const EdgeInsets.only(
                          top: 150.0, left: 10.0, right: 10.0),
                      child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        children: <Widget>[
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: _changeLogInScreen,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(height: 10.0),
                                      const Text(
                                        "LOGIN",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        height: 2.0,
                                        width: 60.0,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: _changeRegisterScreen,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        child: const Text(
                                          "SIGNUP",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                _textField("Email", Icons.person_outline,
                                    _emailController),
                                SizedBox(height: 10.0),
                                _textField("Password", Icons.remove_red_eye,
                                    _passwordController),
                                SizedBox(height: 50.0),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: const Color(0xffffffff),
                      shadowColor: Colors.green,
                      margin: const EdgeInsets.only(
                          top: 150.0, left: 10.0, right: 10.0),
                      child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        children: <Widget>[
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: _changeLogInScreen,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        height: 20.0,
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        child: const Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _changeRegisterScreen,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        child: const Text(
                                          "SIGNUP",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        height: 2.0,
                                        width: 60.0,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                _textField("Email", Icons.person_outline,
                                    _nameController),
                                SizedBox(height: 10.0),
                                _textField("Password", Icons.remove_red_eye,
                                    _emailController),
                                SizedBox(height: 10.0),
                                _textField("Password", Icons.remove_red_eye,
                                    _passwordController),
                                SizedBox(height: 50.0),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _isLoginScreen ? login() : registerUser();
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(top: _isLoginScreen ? 360.0 : 430.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 2.0,
                            offset: Offset(0, 5),
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Material(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xfffabc63),
                                Color(0xfff28c91),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 2.0,
                                offset: Offset(0, 2),
                              )
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 530.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      _isLoginScreen ? "Or Sign Up With" : "SIGN IN WITH",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Google"),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                          shape: StadiumBorder(),
                        ),
                        RaisedButton(
                          onPressed: () {},
                          shape: StadiumBorder(),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Facebook"),
                          ),
                          color: Colors.indigo,
                          textColor: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
