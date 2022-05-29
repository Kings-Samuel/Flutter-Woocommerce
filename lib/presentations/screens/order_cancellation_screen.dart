import 'package:flutter/material.dart';
import 'package:woocommerce/models/order.dart';

class OrderCancellattionScreen extends StatefulWidget {
  const OrderCancellattionScreen(
      {Key? key, required this.model})
      : super(key: key);
  final OrderModel model;

  @override
  State<OrderCancellattionScreen> createState() => _OrderCancellattionScreenState();
}

class _OrderCancellattionScreenState extends State<OrderCancellattionScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? userReason;
  FocusNode focusNode = FocusNode();
  bool isLoading = false;

  // ignore: todo
  //TODO: remember to add model details to user reasons when sending the mail

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "Cancel Order",
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
                  "Let us know why you are cancelling this order. Kindly note that orders cannot be cancelled after they are prepared for shipping",
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
                          return 'Field is required.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter a valid reason here',
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
                    const SizedBox(height: 50),
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
                      onPressed: () {},
                      child: isLoading == true
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
                  ]),
                ),
              ],
            ))));
  }
}
