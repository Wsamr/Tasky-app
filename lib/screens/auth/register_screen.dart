import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_dialog.dart';
import 'package:tasky_app/core/utils/auth_validators.dart';
import 'package:tasky_app/core/utils/responsive.dart';
import 'package:tasky_app/data/firebase/firebase_auth.dart';
import 'package:tasky_app/screens/auth/login_screen.dart';
import 'package:tasky_app/screens/auth/widgets/main_button_widget.dart';
import 'package:tasky_app/screens/auth/widgets/button_text_auth.dart';
import 'package:tasky_app/screens/home/home_screen.dart';
import 'package:tasky_app/widgets/text_form_felid_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static String routeName = "RegisterScreen";
  var userName = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmpassword = TextEditingController();
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
              SizedBox(height: heightResponsive(context, 97)),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: widthResponsive(context, 32),
                  fontWeight: FontWeight.bold,
                  color: Color(0xff24252C),
                ),
              ),
              SizedBox(height: heightResponsive(context, 23)),
              Text(
                "Username",
                style: TextStyle(
                  fontSize: widthResponsive(context, 16),
                  fontWeight: FontWeight.w400,
                  color: Color(0xff24252C),
                ),
              ),
              SizedBox(height: 5),
              TextFormFelidWidget(
                hintText: "Enter your userName",
                controller: userName,
                validator: AuthValidators.validateUsername,
              ),
              SizedBox(height: heightResponsive(context, 24)),
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
              SizedBox(height: heightResponsive(context, 24)),
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
                hintText: "Password...",
                controller: password,
                validator: AuthValidators.validatePassword,
              ),
              SizedBox(height: heightResponsive(context, 24)),
              Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: widthResponsive(context, 16),
                  fontWeight: FontWeight.w400,
                  color: Color(0xff24252C),
                ),
              ),
              SizedBox(height: 5),
              TextFormFelidWidget(
                hintText: "Password...",
                controller: confirmpassword,
                validator: (confirmPassword) {
                  return AuthValidators.validateConfirmPassword(
                    password.text,
                    confirmPassword,
                  );
                },
              ),
              SizedBox(height: heightResponsive(context, 41)),
              MainBottonWidget(
                background: Color(0xff5F33E1),
                titleColor: Colors.white,
                title: "Register",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    AppDialog.showDialogLoading(context);
                    await FirebaseAuthication.register(
                          userName.text,
                          email.text,
                          password.text,
                        )
                        .then((value) {
                          email.clear();
                          password.clear();
                          userName.clear();
                          confirmpassword.clear();
                          Navigator.of(context).pop();
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(LoginScreen.routeName);
                        })
                        .catchError((error) {
                          Navigator.of(context).pop();

                          AppDialog.showDialogError(context, error);
                        });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BottonTextAuth(
        mainText: "Already have an account? ",
        hyperText: "Login",
        onTap: () {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        },
      ),
    );
  }
}
