import 'package:googleapis_auth/auth_io.dart';

class AccessToken {
   String firebaseMessagingscope= "https://www.googleapis.com/auth/firebase.messaging";
  Future <String> getAccessToken()async{
    final client = await clientViaServiceAccount(ServiceAccountCredentials.fromJson({
   "type": "service_account",
  "project_id": "mastering-firebase-25daa",
  "private_key_id": "263924831032ebc5e48d3af2e4c32e5d0da44b6e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDQEfi2uTBmx6Nw\n4wD6f8XSaJcfGhLHYV6LZETMRWu1LKXuRD22kXD7QFyRa/B3Z7zZY57uoc/lOCIs\nQ4d/z0V+eR7d04TENW/Io4+E8rXXIJ5g/cn2RDsmSrGB0KDlozYkViXaIyy3Apo2\nOTtjzNitjvmC67YHKmEuqMgWkd2XGlhxjsB2vEJkWPE6LKhh/epcEAfcxFs9zSr1\nQgo4FoAnslF0zLypBnnVAAFF3YNxbAsaC2Vv9lXnJFppCf4qA5LADAh5XnvF6k5Y\n3JdM+9gTTWXzQXlx02opOEpO2ens/sDW3gEl85Ct46JpCsIHlbELiRM/RHNrQzvb\nWW60pnBXAgMBAAECggEAAm4BsgLymj8NkD8BkjgVjTH0eQQBOrvPDCCoUjXwHoyX\n0wyP9FOGQ4c9k+MnSs9Dm/3dhSeoxlWQxjFZrtF/go0TVUxn7TFuJz3yg8wG+WA9\nPG1Qqb2jofxWtOkRrLmdsCOJy9GdiMH3UnFgcxD/nMAIXauD+iYLPkckfJyVpYyM\nHn07qY6w5ViYeB1IN+AYDEW7hXrc3txQ7NquXi6uoWbEfMDNtk41vqY/+8ky92qq\nryKH5XkYVhGJJyQpsCuVNTG63fRZoNNpsRtPsV6ztlKTIXoSvXwCLfoqwoEoBTro\nXKlTBWhkwxU8RFprWb+/HSdTZl/Lsx05vPHE4OGuVQKBgQDpCP3m9orzMdOvY1NP\nTJ+D5kEV+SXlDE267VuXsDmknWNl3HsTxFEktDRv0X2hFPF288FFLKHSnwbbNLRB\nC+FfSrqktSh8fWiMT1cWMqoYAc/amqKPcwGM4Y4ihmXNKvAwSlVS3r3uM3zBAQli\nFKGxLdowAIk8ghgrviS1CIMAhQKBgQDkkyo0dQCNtGnSgt65AGQUP8IaDz6KfYC2\np9xFWci3QGHkBzY92O0cpKCKDMhmnvfaKW3OxnXtXeaydX34akcSP8invnOenjpV\nlS2YbKTQnkot5oSuzSmNIuLxVZxyIR1z9XDNeiZ90uFlAYy66aecJg7GCtmycRq4\nrvMFHuwSKwKBgQCEmTw4LrMz3HdSRhdCeRwPJnaEdUdtxIl6QtMqRfkWxQOpE0Lp\nJXzygKORuMdeYBdhkyO3I8VUnm59Tsj+di8gVNpNHFPUOlvB8udf1yZYELff8Ltt\nGoiYTEPfO1Az5SnUoIdaZyn1n1BuVhOrvoee1LNhOvzb9D6irUgfxp8cLQKBgQDT\n3Xy/RrwOnO2BjIB5Jl2dT0PQ99RWdeH6bDkFpyUehnS18eFbDlkptYaArzyJsku2\nUbRQdzATpngRbkonGgtqZOjOYv+0RKF5dl7e68URAcdsKEFP7SbYhT+pxlrOhtdQ\nBm5aZyCKfA8jmn4hOjZ7y+Lhumjyt1e3W6IyWukiJQKBgET8qoMZDUqW5m0WWRgV\nZDORGmRBNDCxfC1inG/TJC+0425HhfTAk/cZ7pd2KGJUuKyaMUf/Ao9hIyaxPExw\nbMd9HRlG8J+gzBAY35GJ5As1UaWPNY7AS87saG07/OXx7cqSzxwiKJHMzyJr6cwk\n8NPDME0HX+EhYXdsDDiug39Z\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-50vgu@mastering-firebase-25daa.iam.gserviceaccount.com",
  "client_id": "101081755704137298975",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-50vgu%40mastering-firebase-25daa.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
    }), [firebaseMessagingscope]);
    final accessToken = client.credentials.accessToken.data;
    print("=============================================");
    print(accessToken);
    return accessToken;
  }

}