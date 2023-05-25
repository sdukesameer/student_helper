import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_helper/components/main_button.dart';
import 'package:student_helper/helpers/font_size.dart';
import 'package:student_helper/helpers/theme_colors.dart';
import 'package:student_helper/services/auth_service.dart';
class ResetPage extends StatefulWidget {
 static String routename="resetpassword";

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final auth_service _auth = new auth_service();
  bool _isLoading = false;
  TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ThemeColors.scaffoldBgColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset Your Password",
                  style: GoogleFonts.poppins(
                    color: ThemeColors.whiteTextColor,
                    fontSize: FontSize.xxLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    "Please provide your mail.",
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
                SizedBox(height: 70,),
                MainButton(
                    text: _isLoading?"Loading...":"Reset",
                    onTap: ()async {
                      setState(() {
                        _isLoading=true;
                      });
                      if(_emailController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fields cannot be empty")));
                      }
                      else{
                        await _auth.sendPasswordResetEmail(_emailController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please check your mail for reset link!")));
                        Future.delayed(Duration(seconds: 1),(){
                          Navigator.pop(context);
                        });

                      }
                      setState(() {
                        _isLoading=false;
                      });
                    } //{_formKey.currentState!.validate();}
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
