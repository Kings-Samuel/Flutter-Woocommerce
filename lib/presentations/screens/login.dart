import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/presentations/screens/signup.dart';
import 'package:woocommerce/services/woocommerce_api_service.dart';
import 'package:woocommerce/main.dart';
import '../../services/providers/social_login.dart';
import '../widgets/elevated_button.dart';
import '../widgets/progress_indicator_modal.dart';
import '../../utils/shared_prefs.dart';
import '../widgets/snackbar.dart';
import 'reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? username;
  String? password;
  final WooApiService _apiService = WooApiService();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ProgressModal(child: _formUI(context), inAsyncCall: isApiCallProcess);
  }

  Widget _formUI(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 150),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                //wlc txt
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.red, fontFamily: 'Baloo Da 2'),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //email
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle( fontFamily: 'Baloo Da 2'),
                  onSaved: (input) => username = input,
                  validator: (input) => !input!.contains('@') ? "Please enter a valid email" : null,
                  focusNode: focusNode1,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle( fontFamily: 'Baloo Da 2'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.red,
                      )),
                ),
                const SizedBox(height: 10),

                //password
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle( fontFamily: 'Baloo Da 2'),
                  onSaved: (input) => password = input,
                  validator: (input) => input!.length < 3 ? "Password should be more than 4 characters" : null,
                  focusNode: focusNode2,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle( fontFamily: 'Baloo Da 2'),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.red,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        color: Colors.red,
                        icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                      )),
                ),
                const SizedBox(height: 10),

                // sign up & forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //signup
                    TextButton(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen())), 
                      child: const Text(
                        "Click here to Sign Up",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Baloo Da 2'),
                      ),
                      ),

                    //forgot password
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResetPasswordScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Text(
                            "Forgot your Password?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Baloo Da 2',
                            ),
                          ),
                          SizedBox(width: 10),
                          FaIcon(FontAwesomeIcons.rightLong, color: Colors.red)
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                //submit button
                elevatedButton(icon: Icons.login, text: 'LOGIN', onPressed: submit),

                //login with social media
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Or Log in with',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Baloo Da 2',),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios, size: 14),
                  ],
                ),
                const SizedBox(height: 10),
                elevatedButton(
                    icon: Icons.facebook,
                    text: 'Facebook',
                    onPressed: facebookSignIn,
                    backgroundColor: Colors.blueAccent),
                const SizedBox(height: 10),
                elevatedButton(icon: CommunityMaterialIcons.google, text: 'Google', onPressed: googleSignIn)
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    focusNode1.unfocus();
    focusNode2.unfocus();
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void submit() {
    if (validateAndSave()) {
      setState(() {
        isApiCallProcess = true;
      });

      _apiService.loginCustomer(username, password).then((ret) {
        if (ret.data != null) {
          setState(() {
            isApiCallProcess = false;
          });
          SharedService.setLoginDetails(ret);

          snackbar(context, "✅✅✅ Login Successful", Colors.white, Colors.green);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const Base(),
              ),
              (route) => false);
        } else {
          setState(() {
            isApiCallProcess = false;
          });
          snackbar(context, "🚫 Invalid Credentials", Colors.white, Colors.red);
        }
      });
    }
  }

  void facebookSignIn() {
    setState(() {
      isApiCallProcess = true;
    });
    Provider.of<SocialLogin>(context, listen: false).fblogin(context).then((value) {
      setState(() {
        isApiCallProcess = false;
      });
    });
  }

  void googleSignIn() {
    setState(() {
      isApiCallProcess = true;
    });
    Provider.of<SocialLogin>(context, listen: false).googleLogin(context).then((value) {
      setState(() {
        isApiCallProcess = false;
      });
    });
  }
}
