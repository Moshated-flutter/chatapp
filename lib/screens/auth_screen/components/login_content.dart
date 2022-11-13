import 'package:chatapp/screens/auth_screen/animations/change_screen_animation.dart';
import 'package:chatapp/screens/auth_screen/components/text_widgets/bottom_text.dart';
import 'package:chatapp/screens/auth_screen/components/text_widgets/toptext.dart';
import 'package:chatapp/utils/constrans.dart';
import 'package:chatapp/utils/helper_funtions.dart';
import 'package:flutter/material.dart';

enum Screens {
  createAccount,
  login,
}

class Logincontent extends StatefulWidget {
  const Logincontent({super.key});

  @override
  State<Logincontent> createState() => _LogincontentState();
}

class _LogincontentState extends State<Logincontent>
    with TickerProviderStateMixin {
  final formkeyEmialLog = GlobalKey<FormState>();
  final formkeyEmialSign = GlobalKey<FormState>();
  final formkeyPasswordLog = GlobalKey<FormState>();
  final formkeyPasswordSing = GlobalKey<FormState>();
  final formkeyUser = GlobalKey<FormState>();

  late final List<Widget> createAccountcontent;
  late final List<Widget> logincontent;

  String _useremail = '';
  String _username = '';
  String _userpassword = '';

  @override
  void initState() {
    createAccountcontent = [
      inputField('Name', Icons.person, false, formkeyUser),
      inputField('Email', Icons.mail_outline, false, formkeyEmialSign),
      inputField('Password', Icons.key_rounded, true, formkeyPasswordSing),
      loginbuttom('sign in'),
      ordivider(),
      logos(),
    ];
    logincontent = [
      inputField('Email', Icons.mail_outline, false, formkeyEmialLog),
      inputField('Password', Icons.key_rounded, true, formkeyPasswordLog),
      loginbuttom('Log in'),
      forgetpassword(),
    ];
    ChangeScreenAnimations.initialze(
      createaccontItems: createAccountcontent.length,
      loginitem: logincontent.length,
      vsync: this,
    );
    for (var i = 0; i < createAccountcontent.length; i++) {
      createAccountcontent[i] = HellperFunctions.wrapwithAnimationBuilder(
        animation: ChangeScreenAnimations.createAccountAnimation[i],
        child: createAccountcontent[i],
      );
    }

    for (var i = 0; i < logincontent.length; i++) {
      logincontent[i] = HellperFunctions.wrapwithAnimationBuilder(
        animation: ChangeScreenAnimations.loginAnimation[i],
        child: logincontent[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimations.dispose();
    super.dispose();
  }

  Widget inputField(String hint, IconData iconData, bool obscure,
      GlobalKey<FormState> formkey) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 55,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: Form(
            key: formkey,
            child: TextFormField(
              validator: (value) {
                if (hint == 'Email') {
                  if (value!.isEmpty) {
                    return 'This field cant be empty ';
                  }
                  if (!value.contains('@')) {
                    return 'please enter a valid value';
                  }
                }
                if (hint == 'Password') {
                  if (value!.isEmpty) {
                    return 'This field cant be empty ';
                  }
                  if (value.length < 7) {
                    return 'please enter at least 7 characters';
                  }
                }
                if (hint == 'Name') {
                  if (value!.isEmpty) {
                    return 'This field cant be empty ';
                  }
                  if (value.length < 4) {
                    return 'please enter at least 4 characters';
                  }
                }
                return null;
              },
              onSaved: (newValue) {
                if (hint == 'Email') {
                  _useremail = newValue!;
                }
                if (hint == 'Password') {
                  _userpassword = newValue!;
                }
                if (hint == 'Name') {
                  _username = newValue!;
                }
              },
              obscureText: obscure,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: hint,
                prefixIcon: Icon(iconData),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formwidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Form(
          child: Column(
        children: [
          if (ChangeScreenAnimations.currentScreen == Screens.login)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 12,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Container(
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Container(
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget loginbuttom(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 154, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (ChangeScreenAnimations.currentScreen == Screens.createAccount) {
            final emailValid = formkeyEmialSign.currentState!.validate();
            final uservalid = formkeyUser.currentState!.validate();
            final passValid = formkeyPasswordSing.currentState!.validate();
            if (emailValid && uservalid && passValid) {
              formkeyEmialSign.currentState!.save();
              formkeyPasswordSing.currentState!.save();
              formkeyUser.currentState!.save();
              print(_useremail);
              print(_userpassword);
              print(_username);
            }
          }
          if (ChangeScreenAnimations.currentScreen == Screens.login) {
            final emailvalid = formkeyEmialLog.currentState!.validate();
            final passvalid = formkeyPasswordLog.currentState!.validate();
            if (emailvalid && passvalid) {
              formkeyEmialLog.currentState!.save();
              formkeyPasswordLog.currentState!.save();
            }
          }
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          primary: ksecondacycolor,
          shape: const StadiumBorder(),
        ),
      ),
    );
  }

  Widget ordivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              color: kprimarcolors,
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'or',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            child: Container(
              color: kprimarcolors,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget logos() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/facebook.png'),
          SizedBox(width: 30),
          Image.asset('assets/images/google.png'),
        ],
      ),
    );
  }

  Widget forgetpassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        child: Text(
          'Forget password',
          style: TextStyle(
              color: ksecondacycolor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: TopText(),
          bottom: 600,
          left: 50,
        ),
        Padding(
          padding: EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createAccountcontent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: logincontent,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: BottomText(),
          ),
        )
      ],
    );
  }
}
