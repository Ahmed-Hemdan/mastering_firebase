import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({super.key});

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  @override
  void initState() {
    print("goooooooooooooooooooooooooooooooooo");
    print("Initializing Firebase Messaging");

  FirebaseMessaging.instance.getToken().then((token) {
    print("FCM Token: $token");
  });
     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print("========================");
        print(
            'Message also contained a notification: ${message.notification!.title}');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.data["name"] ?? "")));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send message"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // await sendMessage("HI", "How are you");
          },
          child: Text("send message"),
        ),
      ),
    );
  }
}

// sendMessage(String messageBody, messageTitle) async {
//  var headersList = {
//  'Accept': '*/*',
//  'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
//  'Content-Type': 'application/json',
//  'Authorization': 'Bearer ya29.c.c0AY_VpZisGfI84BHZKKKU3pXGVgFyMBe9JKDz9Oogo70HPrCzuisxoX4DXkTuKG22BWd256l9wKL9GX_6yGs6ejXphro2QKgkQVZmGz0qSybIYm_Z-nTIQ9i2JubV8slQRF52fL6Ev2gkRZ2XCcx1eTYFZNOSvuFYPODDUnFwBFpVoDotyhk_Pxwi1v5q8NANcHF1lksA1AWeQABoDG5-Y9ANTMKewE-Gw9OwhJJyTxC7naFs1LiGdyYDD10XXvwkGt9V2YADkpEcGBIfOgJA6AErIJ_3GW02rEr2wY2gnPh2Y31TrOGVtZ67Z1_aXaPffmUJRMxsOoeK5Ur7bxaB3tLjAdnrpmOdRq8OvQOLOmEU_7j7KGE2W1cH384KldnIR__hR-yq8xw2hUYyruZzBcZzq0aq4mYm6zhj234yzYFI81oWU8IWX8101a_djISltrm9lxkdI12lQwOeRckFqsM55FpWq000em2j2Ibhve1vMOYZ1jStI30S1g9iiqvFpWrjWOkeSsM6a4f4YX95XX6g9opWpYao1QJF8Rpmbr8oOSf57webUxXZktkZYjkm7t5b5j0_biBSsqX6tt54c4Ik0n2qq2ts80SuJYj00ZpB-1FxiRgV3JcpO_gluV5v-MzR5ecV6Q3nXYpW4dmhRd9rhfMmM2frhj93-voOUbF_srbYOeZrMcqvzIOiOf1qw7tSfbs7UQFVn0vyUp8_uOotipSvxxFrjJ47VUV2Fo2tUYyuZ0rcs1Yw0ggV6f60z_qp8r6wgk1Ih5VjqY_RMqo2bg1cSfFsSSzn4ad_R-hiv5ka_eIv0w5wecQv-eXR0r6whj-ou64xSgZ1ymhBuQM7UflX7JW9ViJ6wtXztB8Bpd9BMWzcSFXqqkrQsrIZtuVX7kzWhr4BW_6F8b03keB9hV0dSluMdwhvI32vtyjyJx9QS5v-wXcdixVa4h3wUjp1t7ep98X28yOhIvhZSMWOQqkfeiBWJprUl6--YnvghgXSfuhIJr' 
// };
// var url = Uri.parse('https://fcm.googleapis.com/v1/projects/mastering-firebase-25daa/messages:send');

// var body = {
//   "message": {
//     "token": "fi7EwdlzTfyd7Y-OiNkcmJ:APA91bFOpvbYC8y920TpelH48EgkNoy0a4lX_tJf-xKwuW0NErFGenmRispGveUAikL6MxuIObJf1dDOZsFOI64un3LzhsWaGY-fZnhqB28DhRa9KDwdVdaOzfZEhygN-mhCyiLrz8HL",
//     "notification": {
//       "body": "Hello",
//       "title": "الحمد لله"
//     } ,
//     "data": {
//       "name": "Hemdannnnn"
//     }
//   }
// };

// var req = http.Request('POST', url);
// req.headers.addAll(headersList);
// req.body = json.encode(body);


// var res = await req.send();
// final resBody = await res.stream.bytesToString();

// if (res.statusCode >= 200 && res.statusCode < 300) {
//   print(resBody);
// }
// else {
//   print(res.reasonPhrase);
// }
// }
