import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_dialog.dart';
import 'package:tasky_app/core/utils/auth_validators.dart';
import 'package:tasky_app/core/utils/responsive.dart';
import 'package:tasky_app/data/firebase/firebase_auth.dart';
import 'package:tasky_app/screens/auth/register_screen.dart';
import 'package:tasky_app/screens/auth/widgets/main_button_widget.dart';
import 'package:tasky_app/screens/auth/widgets/button_text_auth.dart';
import 'package:tasky_app/screens/home/home_screen.dart';
import 'package:tasky_app/widgets/text_form_felid_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static String routeName = "LoginScreen";
  var email = TextEditingController();
  var password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: heightResponsive(context, 122)),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: widthResponsive(context, 32),
                  fontWeight: FontWeight.bold,
                  color: Color(0xff24252C),
                ),
              ),
              SizedBox(height: heightResponsive(context, 53)),
              Text(
                "email",
                style: TextStyle(
                  fontSize: widthResponsive(context, 16),
                  fontWeight: FontWeight.w400,
                  color: Color(0xff24252C),
                ),
              ),
              SizedBox(height: 5),
              TextFormFelidWidget(
                hintText: "Enter your Email",
                controller: email,
                validator: AuthValidators.validateEmail,
              ),
              SizedBox(height: heightResponsive(context, 26)),
              Text(
                "Password",
                style: TextStyle(
                  fontSize: widthResponsive(context, 16),
                  fontWeight: FontWeight.w400,
                  color: Color(0xff24252C),
                ),
              ),
              SizedBox(height: 5),
              TextFormFelidWidget(
                hintText: "Enter your password",
                controller: password,
                validator: AuthValidators.validatePassword,
              ),
              SizedBox(height: heightResponsive(context, 71)),
              MainBottonWidget(
                titleColor: Colors.white,
                background: Color(0xff5F33E1),
                title: "Login",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    AppDialog.showDialogLoading(context);
                    await FirebaseAuthication.login(email.text, password.text)
                        .then((value) {
                          email.clear();
                          password.clear();
                          Navigator.of(context).pop();
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(HomeScreen.routeName);
                        })
                        .catchError((error) {
                          Navigator.of(context).pop();
                          AppDialog.showDialogError(context, error.toString());
                        });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BottonTextAuth(
        mainText: "Don’t have an account? ",
        hyperText: "Register",
        onTap: () {
          Navigator.of(context).pushNamed(RegisterScreen.routeName);
        },
      ),
    );
  }
}
