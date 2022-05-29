import 'package:flutter/material.dart';
import 'package:woocommerce/presentations/widgets/elevated_button.dart';

class ReportBugs extends StatefulWidget {
  const ReportBugs(
      {Key? key})
      : super(key: key);

  @override
  State<ReportBugs> createState() => _ReportBugsState();
}

class _ReportBugsState extends State<ReportBugs> {
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? report;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "Report Bugs",
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
                  "If you have encountered any issue while using the app, kindly tell us below so that we can fix it as soon as possible. Your feedback is highly appreciated. Thank you",
                  style: TextStyle( 
                      fontFamily: 'baloo da 2',
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
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
                        report = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your feedback here',
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
                    isApiCallProcess
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ) :
                        elevatedButton(
                          icon: Icons.send, 
                          text: 'Send',
                          onPressed: () {
                            if (globalKey.currentState!.validate()) {
                          globalKey.currentState!.save();
                          setState(() {
                            isApiCallProcess = true;
                          });
                        }
                          }
                        ),
                      ]),
                ),
              ],
            ))));
  }

}
