import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:woocommerce/services/providers/delete_acct_provider.dart';
import 'package:woocommerce/services/woocommerce_api_service.dart';
import '../../main.dart';
import 'privacy_policy.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount(
      {Key? key, required this.userEmail, required this.userName})
      : super(key: key);
  final String userEmail;
  final String userName;

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? userReason;
  late WooApiService apiService;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    apiService = WooApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "Delete Account",
            style: TextStyle(
                fontFamily: 'baloo da 2',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.chevron_left, color: Colors.black)),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "We're sorry to see you go. 😢 \n Kindly note that your details are safe with us. \n Please state why you want to delete your account below.",
                  style: TextStyle(
                      fontFamily: 'baloo da 2',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Form(
                  key: globalKey,
                  child: Column(children: <Widget>[
                    TextFormField(
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'baloo da 2',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: focusNode,
                      onSaved: (value) {
                        userReason = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please help us understand why you want to delete your account.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'I want to delete my account because...',
                        hintStyle: const TextStyle(
                            fontFamily: 'baloo da 2',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black54),
                        errorStyle: const TextStyle(
                          fontFamily: 'baloo da 2',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.red,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.all(6),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Please note that you will not be able to recover your account once you delete it. \n Are you sure you want to delete your account?",
                      style: TextStyle(
                          fontFamily: 'baloo da 2',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red),
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 50)),
                        maximumSize:
                            MaterialStateProperty.all(const Size(200, 50)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        var deleteAcctProvider = Provider.of<DeleteAccountProvider>(context, listen: false);

                        if (globalKey.currentState!.validate()) {
                          globalKey.currentState!.save();
                          setState(() {
                            isApiCallProcess = true;
                          });
                          deleteAcctProvider.deleteAccount().then((value) {
                            sendEmail().whenComplete(() => {
                                setState(() {
                                  isApiCallProcess = false;
                                }),
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Base())),
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 4),
                                  content: Text(
                                    'Your account has been deleted successfully',
                                    style: TextStyle(
                                        fontFamily: 'baloo da 2',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                              });
                          });
                        }
                      },
                      child: isApiCallProcess
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              "Delete Account",
                              style: TextStyle(
                                  fontFamily: 'baloo da 2',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                    ),
                    Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      // padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.only(top: 60),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Visit our ',
                              style: const TextStyle(
                                  fontFamily: 'baloo da 2',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: 'privacy policy',
                                    style: const TextStyle(
                                        fontFamily: 'baloo da 2',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.red),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrivacyPolicy()));
                                      }),
                                const TextSpan(
                                    text:
                                        ' page to undertsand how we use your data',
                                    style: TextStyle(
                                        fontFamily: 'baloo da 2',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.black)),
                              ])),
                    ),
                  ]),
                ),
              ],
            ))));
  }

  Future sendEmail() async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'https://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': 'service_ra2esbu',
        'template_id': 'template_ol2tjky',
        'user_id': 'J9vhxf-o0zEfmZdbd',
        'template_params': {
          'user_email': widget.userEmail,
          'user_name': widget.userName,
          'user_message': userReason,
        }
      }),
    );
    // ignore: avoid_print
    print(response.body);
  }
}
