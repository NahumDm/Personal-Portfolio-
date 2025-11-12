class EmailJsSecrets {
  const EmailJsSecrets._();

  static const String serviceId = String.fromEnvironment(
    'EMAILJS_SERVICE_ID',
    defaultValue: 'service_ic9rd5v',
  );
  static const String templateId = String.fromEnvironment(
    'EMAILJS_TEMPLATE_ID',
    defaultValue: 'template_dntzj2r',
  );
  static const String publicKey = String.fromEnvironment(
    'EMAILJS_PUBLIC_KEY',
    defaultValue: 'ETzRslnvCouwsSPwe',
  );
}
