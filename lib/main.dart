import 'package:flutter/material.dart';
import 'package:nanohealthsuite/Screens/MainPage/Widgets/login_fields_widget.dart';
import 'package:nanohealthsuite/utils/colors_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NanoHealthSuite',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    Gradient _gradient =  const LinearGradient(
        colors: [ColorsUtils.firstColor, ColorsUtils.secondColor]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: double.infinity,
                decoration: BoxDecoration(gradient: _gradient),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logonano.png",
                        height: 200,
                        width: 200,
                      ),
                    ),
                    const Align(
                        alignment: Alignment.bottomLeft,
                      child:Padding(padding: EdgeInsets.only(left: 15,top: 30),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              fontFamily: "SF Pro Display",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                              fontSize: 34),
                        ),
                      )

                    ),
                  ],
                )

              ),
              Positioned(
                top: 400,
                left: 15,
                right: 15,
                child: LoginFieldsWidget()
              )
            ],
          ),
        ),
      ),
    );
  }
}
