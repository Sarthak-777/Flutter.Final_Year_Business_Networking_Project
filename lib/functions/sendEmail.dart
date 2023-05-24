import 'dart:convert';

import 'package:http/http.dart' as http;

Future sendEmail({
  required String name,
  required String email,
  required String subject,
  required String message,
}) async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': 'service_yeybkv3',
        'template_id': "template_kp0ut0n",
        'user_id': "user_g4FIsR5GLvKIPb9Tg6mRw",
        'template_params': {
          'user_name': name,
          "user_email": email,
          "user_subject": subject,
          "user_message": message
        }
      }));
}
