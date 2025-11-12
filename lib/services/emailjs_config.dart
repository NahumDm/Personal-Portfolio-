import 'emailjs_secrets.dart';

class EmailJsConfig {
  EmailJsConfig._();

  static const String serviceId = EmailJsSecrets.serviceId;
  static const String templateId = EmailJsSecrets.templateId;
  static const String publicKey = EmailJsSecrets.publicKey;

  static Map<String, dynamic> templateParams({
    required String name,
    required String phone,
    required String email,
    required String time,
    required String message,
  }) {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'time': time,
      'message': message,
    };
  }
}
