import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woocommerce/presentations/widgets/elevated_button.dart';

class AboutDeveloper extends StatefulWidget {
  const AboutDeveloper({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutDeveloper> createState() => _AboutDeveloperState();
}

class _AboutDeveloperState extends State<AboutDeveloper> {
  String imageUrl =
      'https://scontent.fabv2-1.fna.fbcdn.net/v/t1.6435-9/56242461_1954349918025923_2290346080014958592_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=8bfeb9&_nc_eui2=AeELZ85XO7GiA39ip8Bh1w33JD44LWUu-d0kPjgtZS753fNIjeU2YqiAFqMnxdVLeRDNzOTgMzIpKmBe2fkptF4_&_nc_ohc=6J_vFGfAL6MAX8RZiGj&_nc_ht=scontent.fabv2-1.fna&oh=00_AT8jfVKTTtrtMn0dqaLEgfCFuDAJrXK-yPJvq1mLzlCvAQ&oe=62B4477C';
  String portfolioUrl = 'https://samuelkings.web.app';

  String linkedIn = 'https://www.linkedin.com/in/samuel-kings-3a46971b0/';
  String twitter = 'https://twitter.com/apstkingssamuel';
  String whatsApp = 'https://wa.link/d0abss';
  String upwork = 'https://www.upwork.com/freelancers/~011d789669267e4a0c';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "About Developer",
          style: TextStyle(fontFamily: 'baloo da 2', fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            scale: 1.0)),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text:
                            "Hi 🖐, I'm Samuel Kings. \n I am a fullstack web, mobile and desktop developer. \n Check out my portfolio on ",
                        style: const TextStyle(
                            fontFamily: 'baloo da 2', fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black),
                        children: [
                          TextSpan(
                            text: portfolioUrl,
                            style: const TextStyle(fontSize: 12, color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchUrl(portfolioUrl);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Connect with me on social media",
                  style: TextStyle(
                      fontFamily: 'baloo da 2', fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                alignment: Alignment.center,
                child: elevatedButton(
                    icon: CommunityMaterialIcons.linkedin,
                    text: 'Linkedin',
                    backgroundColor: const Color(0xFF0077B5),
                    onPressed: () {
                      _launchUrl(linkedIn);
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 0.5,
                alignment: Alignment.center,
                child: elevatedButton(
                    icon: CommunityMaterialIcons.twitter,
                    text: 'Twitter',
                    backgroundColor: Colors.blue,
                    onPressed: () {_launchUrl(twitter);}),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 20),
                width: MediaQuery.of(context).size.width * 0.5,
                alignment: Alignment.center,
                child: elevatedButton(
                    icon: CommunityMaterialIcons.whatsapp,
                    text: 'WhatsApp',
                    backgroundColor: Colors.green,
                    onPressed: () {
                      _launchUrl(whatsApp);
                    }),
              ),
              RichText(text: TextSpan(
                  text: 'You can also hire me on ',
                  style: const TextStyle(
                      fontFamily: 'baloo da 2', fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'upwork',
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchUrl(upwork);
                        },
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String _url) async {
    await launchUrl(
      Uri.parse(_url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript : true,
      ),
    );
  }
}
