import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_helper/components/main_button.dart';
import 'package:student_helper/helpers/font_size.dart';
import 'package:student_helper/helpers/theme_colors.dart';
import 'package:student_helper/pages/home_page.dart';
import 'package:student_helper/pages/signup_page.dart';
import 'package:student_helper/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  static String routename = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false,_isGoogleLoading=false;
  final auth_service auth=new auth_service();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's get you in!",
                style: GoogleFonts.poppins(
                  color: ThemeColors.whiteTextColor,
                  fontSize: FontSize.xxLarge,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Text(
                  "Login to your account.",
                  style: GoogleFonts.poppins(
                    color: ThemeColors.greyTextColor,
                    fontSize: FontSize.medium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Email input field
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (_emailController.text.isEmpty) {
                          return "This field can't be empty.";
                        }
                      },
                      style: GoogleFonts.poppins(
                        color: ThemeColors.whiteTextColor,
                      ),
                      cursorColor: ThemeColors.primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: ThemeColors.textFieldBgColor,
                        filled: true,
                        hintText: 'E-mail',
                        hintStyle: GoogleFonts.poppins(
                          color: ThemeColors.textFieldHintColor,
                          fontSize: FontSize.medium,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    //Password input field
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (_passwordController.text.isEmpty) {
                          return "This field can't be empty.";
                        }
                      },
                      obscureText: true,
                      style: GoogleFonts.poppins(
                        color: ThemeColors.whiteTextColor,
                      ),
                      cursorColor: ThemeColors.primaryColor,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        fillColor: ThemeColors.textFieldBgColor,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: GoogleFonts.poppins(
                          color: ThemeColors.textFieldHintColor,
                          fontSize: FontSize.medium,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context,"resetpassword");
                          },
                          child: Text(
                            "Forgot password?",
                            style: GoogleFonts.poppins(
                              color: ThemeColors.greyTextColor,
                              fontSize: FontSize.medium,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 70,
                    ),

                    MainButton(
                      text: _isLoading?"Loading...":"Login",
                      onTap: ()async {
                        setState(() {
                          _isLoading=true;
                        });
                        if(_emailController.text.isEmpty && _passwordController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fields cannot be empty")));
                        }
                        else{
                          final result=await auth.signInWithEmailAndPassword(_emailController.text.trim(), _passwordController.text);
                          if(result["message"]=="Success"){
                            Navigator.pushNamed(context, "home");
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result["message"])));
                          }
                        }
                        setState(() {
                          _isLoading=false;
                        });
                      } //{_formKey.currentState!.validate();}
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MainButton(
                        text: _isGoogleLoading?'Loading..':"Login with Google",
                        backGroundColor: Color.fromARGB(255, 170, 24, 24),
                        textColor: ThemeColors.scaffoldBgColor,
                        iconPath: 'assets/google.png',
                        onTap: () async{
                          setState(() {
                            _isGoogleLoading=true;
                          });
                          try {
                            final UserCredential userCredential =await auth.signInWithGoogle();
                            Navigator.pushNamed(context, "home");
                            setState(() {
                              _isGoogleLoading=false;
                            });
                            // Handle the signed-in user
                            // You can access the user information using userCredential.user
                          } catch (e) {
                            // Handle any errors that occur during the sign-in process
                            setState(() {
                              _isGoogleLoading=false;
                            });
                            print(e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }

                        }

                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.poppins(
                        color: ThemeColors.whiteTextColor,
                        fontSize: FontSize.medium,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          )),
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          color: ThemeColors.primaryColor,
                          fontSize: FontSize.medium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
