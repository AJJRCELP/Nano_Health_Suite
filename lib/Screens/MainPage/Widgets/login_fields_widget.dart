import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../ProductsPage/products_screen.dart';

class LoginFieldsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginFieldsWidgetState();
  }
}
class _LoginFieldsWidgetState extends State<LoginFieldsWidget> {
  final _formKey = GlobalKey<FormState>();
  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  var _userEmailController = TextEditingController(text: "");
  var _userPasswordController = TextEditingController(text: "");
  bool _isPasswordVisible = true;
  bool _isEmailVisible = false;
  String loginValidation = "";
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _emailField(context),
          const SizedBox(height: 10,),
          _passwordField(context),
          const SizedBox(height: 15,),
          _continueButton(context),
          const SizedBox(height: 10,),
          Text(loginValidation,style: const TextStyle(color: Colors.red,fontSize: 14),),
          const SizedBox(height: 30,),
          _helpButton(context),
        ],
      ),
    );
  }
  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: _userEmailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,

      onFieldSubmitted: (_) {

        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      onChanged: (v){
        if(_userEmailController.text == "mor_2314"){
          setState(() {
            _isEmailVisible = true;
          });
        }else{
          setState(() {
            _isEmailVisible = false;
          });
        }
      },
      // validator: (value) => _emailValidation(value),
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "",

        labelStyle: const TextStyle(color: Colors.black,
            fontFamily: "SF Pro Text",fontWeight: FontWeight.w400,fontSize: 13,letterSpacing: -0.41),
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        suffixIcon: Icon(

          _isEmailVisible ? Icons.check_circle_outline : null,
          color: const Color(0xff56C0C1),
          size: 14,
        ),

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _userPasswordController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
      //validator: (value) => _userNameValidation(value),
      obscureText: _isPasswordVisible,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "",

        labelStyle:const TextStyle(color: Colors.black,
            fontFamily: "SF Pro Text",fontWeight: FontWeight.w400,fontSize: 13,letterSpacing: -0.41),
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            }),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
  Widget _continueButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xff2AB3C6),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),

      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius:  const BorderRadius.all(Radius.circular(40.0)),
            onTap: () async {
              if(_userEmailController.text.isEmpty && _userPasswordController.text.isEmpty){
                setState(() {
                  loginValidation = "Please enter credentials";
                });
              }
              else if(_userEmailController.text.isEmpty){
                setState(() {
                  loginValidation = "Please enter the username";
                });
              }
              else if (_userPasswordController.text.isEmpty){
                setState(() {
                  loginValidation = "Please enter the password";
                });
              }
              else {
                final body = {
                  "username": _userEmailController.text,
                  "password": _userPasswordController.text
                };
                final jsonString = json.encode(body);
                final uri = Uri.parse('https://fakestoreapi.com/auth/login');
                var response = await http.post(uri, body: body);
                if (response.statusCode == 200) {
                  loginValidation = "";
                  _navigateToNextScreen(context);
                }
                else {
                  setState(() {
                    loginValidation = response.body;
                  });
                }
              }
            },
            child: const Center(
              child: Text(
                "Continue",
                style: TextStyle(
                  fontFamily: "SF Pro Display",
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 17),
              ),
            )),
      ),
    );
  }
  Widget _helpButton(BuildContext context) {
    return  Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
            onTap: (){
              },
            child: const Center(
              child: Text(
                "NEED HELP?",
                style: TextStyle(
                  letterSpacing: -0.41,
                  fontFamily: "SF Pro Text",
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            )),
      );
  }
}
