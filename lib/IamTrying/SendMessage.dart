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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.notification!.title ?? "")));
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
            await sendMessage("HI", "How are you");
          },
          child: Text("send message"),
        ),
      ),
    );
  }
}

sendMessage(String messageBody, messageTitle) async {
 var headersList = {
 'Accept': '*/*',
 'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
 'Content-Type': 'application/json',
 'Authorization': 'Bearer ya29.c.c0AY_VpZh6iyizMCv8_0NBlbWj8V1QKrJ5F-aW6Tw6fjxOqz4Jke31278djzm1RMR6t4xp3qcQOIvC2bpgkaxuEIRtpV2yxM2v2vph9q9R1BwfsinCgfYIq-drYHyP6lR8ItRMnkchJ1vvpz3YuBk3WE0nmPeMt08AlI6eqP81Qg2_2IdMWPj34F6O_sdYbPoy8_vEnf44vckDLOBn9TRfa5SnoZtAp6pHhE3QnlgryU9nnNL50dz3Z63Ot3ptkU_HwIgXp0sIMU6XfIGKWTn-z_IlMTY5B8vfjtbwwm_kCOjlLDiBCvML3JIF5AP6pSfndVj5KS0FkvGWaIuvpHeaAzdS1UoVCElgmGTGX4PHKNKvKREetXx9gxmuE385Ah5Ogu_7sq0OcagWxVJvMrmn1mx0zb-spa1BBO_0s-9sVjUO4Z_4XVsy1sMFkZ03Okae2mWh0S8qXnByOuXh0Yvoybxw10XFvIyokX4wIS44gnzZiiX8J0gm0FOm7wVF_Y_bscvyZ8qmdYX5n9wpBypJ-R0MxboQzklJir7BJpfI6U0wwtq13Mn3IFvz2lqlhtnX0gtwnIcmUhrl_v71F4ovXO6v80In9Bc_ZU9RJylMquvFS8zooXvJux37kc-oUbZf0cMOhpXoJxYQY7tF26fwfotne3u5imWpVh139h9vnqS9FkmlrOkaRQm1jjbtXJ8jVZIoobXWntvwhUw7Y1euSfc6Mlj380UY0gd_wZZq1r00hM3oc2s2degUsoey_iOqfa6c0J7a0imaz1rnffXZIji8SvFgk0oxpxl2Rco9Mt7QxzjVt954bs84JMa5chOUqOFwW7mQt5I2si-dfjZISr64bWqufphoWUovc2hmm7weebbd40ouSQvn8csVUOSsXJ2syStMok_F4sWubxRB9Jf2jJb9JBe9U6IvvQ2bJQ_3ZFY_2UO1OIVZ2kOklkgVuhvl8Va0R70RdeOZQoaYzR-7O4llSR6yb3_2YdhYr0zd3wXxUW1F43' 
};
var url = Uri.parse('https://fcm.googleapis.com/v1/projects/mastering-firebase-25daa/messages:send');

var body = {
  "message": {
    "token": "fi7EwdlzTfyd7Y-OiNkcmJ:APA91bFOpvbYC8y920TpelH48EgkNoy0a4lX_tJf-xKwuW0NErFGenmRispGveUAikL6MxuIObJf1dDOZsFOI64un3LzhsWaGY-fZnhqB28DhRa9KDwdVdaOzfZEhygN-mhCyiLrz8HL",
    "notification": {
      "body": "Hello",
      "title": "الحمد لله"
    }
  }
};

var req = http.Request('POST', url);
req.headers.addAll(headersList);
req.body = json.encode(body);


var res = await req.send();
final resBody = await res.stream.bytesToString();

if (res.statusCode >= 200 && res.statusCode < 300) {
  print(resBody);
}
else {
  print(res.reasonPhrase);
}
}
