import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_helper/components/main_button.dart';
import 'package:student_helper/helpers/font_size.dart';
import 'package:student_helper/helpers/theme_colors.dart';
import 'package:student_helper/pages/login_page.dart';
import 'package:student_helper/services/auth_service.dart';
import 'package:splashscreen/splashscreen.dart';

class StartPage extends StatefulWidget {
  static String routename = "start";

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  final auth_service auth = new auth_service();
  _changeRouteTimer(context,routename) async{
    return routename;
  }
  Future nextRoute(context)async{
      return _changeRouteTimer(context, "home");
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: auth.getUserInstance(),
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator(color: Colors.blue,);
        }
        if(snapshot.hasData){
          return Center(
            child: SplashScreen(
              seconds: 10,
              navigateAfterFuture: nextRoute(context),
              loaderColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
          );
        }
        return Scaffold(
          body: Stack(
            children: [
              Image(
                image: AssetImage('assets/landing.jpeg'),
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fitHeight,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      ThemeColors.scaffoldBgColor,
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0,left: 20,right: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Student Helper',
                          style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 16, 229, 37),
                            fontSize: FontSize.xxxLarge,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Find the best place to stay, eat and many more.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: ThemeColors.whiteTextColor,
                          fontSize: FontSize.medium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: MainButton(
                          onTap: () => Navigator.pushNamed(context, "login"),
                          text: 'Get Started',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
