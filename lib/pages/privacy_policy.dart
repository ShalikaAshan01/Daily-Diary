import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  final TextStyle _heading = TextStyle(fontSize: 25, color: Colors.white);
  final TextStyle _textStyle = TextStyle(color: Colors.white70);
  final String _policy =
      "This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Daily Diary unless otherwise defined in this Privacy Policy.";
  final String _use =
      "For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to First name, Last name, Email Address, Profile Picture. The information that I request will be retained on your device and is not collected by me in any way.The app does use third party services that may collect information used to identify you.Link to privacy policy of third party service providers used by the app. Facebook, Firebase Analystics, Google Play Services";
  final String _log =
      "I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.";
  final String _cookies =
      "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.This Service does not use these 'cookies' explicitly. However, the app may use third party code and libraries that use 'cookies' to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.";
  final String _provider1 =
      "I may employ third-party companies and individuals due to the following reasons:";
  final String _provider2 =
      "I want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.";
  final String _security =
      "I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.";
  final String _links =
      "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.";
  final String _children =
      "These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13\. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do necessary actions.";
  final String _change =
      "I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.";
  final String _contact =
      "If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at shalikaashan01@gmail.com.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: AvatarGlow(
                  endRadius: 90,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white24,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 2),
                  startDelay: Duration(seconds: 1),
                  child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Logo(size: 180),
                        radius: 40.0,
                      )),
                ),
              ),
              Text(
                "Daily Diary",
                style: TextStyle(fontSize: 28),
              )
            ],
          ),
          Text(
            "Privacy Policy",
            style: _heading,
          ),
          space(),
          Text(
            _policy,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "**Information Collection and Use**",
            style: _heading,
          ),
          space(),
          Text(
            _use,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "*   [Google Play Services]",
            textAlign: TextAlign.start,
          ),
          Text(
            "*   (https://www.google.com/policies/privacy/)",
            textAlign: TextAlign.start,
          ),
          Text(
            "*   [Firebase Analytics]",
            textAlign: TextAlign.start,
          ),
          Text(
            "*   (https://firebase.google.com/policies/analytics)",
            textAlign: TextAlign.start,
          ),
          Text(
            "*   [Facebook]",
            textAlign: TextAlign.start,
          ),
          Text(
            "*   (https://www.facebook.com/about/privacy)",
            textAlign: TextAlign.start,
          ),
          space(),
          Text(
            "**Log Data**",
            style: _heading,
          ),
          space(),
          Text(
            _log,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "**Cookies**",
            style: _heading,
          ),
          space(),
          Text(
            _cookies,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "**Service Providers**",
            style: _heading,
          ),
          space(),
          Text(
            _provider1,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "*   To facilitate our Service;",
            textAlign: TextAlign.start,
          ),
          Text(
            "*   To provide the Service on our behalf;",
            textAlign: TextAlign.start,
          ),
          Text(
            "*   To perform Service-related services; or",
            textAlign: TextAlign.start,
          ),
          Text(
            "*   To assist us in analyzing how our Service is used.",
            textAlign: TextAlign.start,
          ),
          space(),
          Text(
            _provider2,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "**Security**",
            style: _heading,
          ),
          space(),
          Text(
            _security,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "**Links to Other Sites**",
            style: _heading,
          ),
          space(),
          Text(
            _links,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "**Children’s Privacy**",
            style: _heading,
          ),
          space(),
          Text(
            _children,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "**Changes to This Privacy Policy**",
            style: _heading,
          ),
          space(),
          Text(
            _change,
            textAlign: TextAlign.justify,
            style: _textStyle,
          ),
          space(),
          Text(
            "**Contact Us**",
            style: _heading,
          ),
          space(),
          Text(
            _contact,
            style: _textStyle,
          ),
        ],
      ),
    );
  }

  Widget space() {
    return SizedBox(
      height: 20,
    );
  }
}
