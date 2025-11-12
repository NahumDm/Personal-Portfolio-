import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../services/emailjs_config.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  OverlayEntry? _feedbackOverlayEntry;

  static const String _phoneNumber = '+251 983204356';
  static const String _emailAddress = 'nahomdesta.dev@gmail.com';
  static const String _location = 'Addis Ababa, Ethiopia';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _feedbackOverlayEntry?.remove();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the link.')),
        );
      }
    }
  }

  Future<void> _handleSend() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      _showFeedbackToast(
        'Please fill in all required fields before submitting.',
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() => _isSending = true);

    final response = await _sendEmail(
      EmailJsConfig.templateParams(
        name: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        time: _currentLocalTimestamp(),
        message: _messageController.text,
      ),
    );

    if (!mounted) return;

    setState(() => _isSending = false);

    if (!response) {
      _showFeedbackToast('Unable to send your message right now.');
      return;
    }

    _showFeedbackToast('Thanks for reaching out');
    _formKey.currentState?.reset();
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  void _showFeedbackToast(String message) {
    // Present form feedback in a compact overlay near the bottom-center of the viewport.
    _feedbackOverlayEntry?.remove();

    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder:
          (context) => Positioned.fill(
            child: IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    color: Colors.transparent,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xFFfd6000),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 18,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(entry);
    _feedbackOverlayEntry = entry;

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (_feedbackOverlayEntry == entry) {
        _feedbackOverlayEntry?.remove();
        _feedbackOverlayEntry = null;
      }
    });
  }

  String _currentLocalTimestamp() {
    final now = DateTime.now();
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    final date = '${now.year}-${twoDigits(now.month)}-${twoDigits(now.day)}';
    final time =
        '${twoDigits(now.hour)}:${twoDigits(now.minute)}:${twoDigits(now.second)}';
    return '$date $time';
  }

  Future<bool> _sendEmail(Map<String, dynamic> templateParams) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': EmailJsConfig.serviceId,
          'template_id': EmailJsConfig.templateId,
          'user_id': EmailJsConfig.publicKey,
          'template_params': templateParams,
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.6),
        fontSize: 14,
      ),
      filled: true,
      fillColor: const Color(0xFF2D2D2D),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFfd6000), width: 1.3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final widthFactor =
        screenWidth < 600
            ? 0.92
            : screenWidth < 900
            ? 0.85
            : 0.7;

    final headingStyle = GoogleFonts.montserrat(
      fontSize: screenWidth < 600 ? 26 : 30,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    final bodyStyle = GoogleFonts.poppins(
      fontSize: screenWidth < 600 ? 14 : 16,
      color: Colors.white.withOpacity(0.85),
      height: 1.6,
    );

    final highlightColor = const Color(0xFFfd6000);

    return Container(
      color: const Color(0xFF232323),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: Center(
        child: SizedBox(
          width: screenWidth * widthFactor,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildIntroColumn(
                        headingStyle,
                        bodyStyle,
                        highlightColor,
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(child: _buildForm(bodyStyle, highlightColor)),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIntroColumn(headingStyle, bodyStyle, highlightColor),
                  const SizedBox(height: 32),
                  _buildForm(bodyStyle, highlightColor),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIntroColumn(
    TextStyle headingStyle,
    TextStyle bodyStyle,
    Color highlightColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Let\'s Connect', style: headingStyle),
        const SizedBox(height: 16),
        Text(
          'Whether you\'re looking to collaborate on projects, discuss an opportunity, or just say hello - I\'d love to hear from you. Reach out any time and let\'s build something great together.',
          style: bodyStyle,
        ),
        const SizedBox(height: 28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap:
                  () => _launchUrl('tel:${_phoneNumber.replaceAll(' ', '')}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone',
                    style: bodyStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _phoneNumber,
                    style: bodyStyle.copyWith(color: highlightColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address',
                  style: bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _location,
                  style: bodyStyle.copyWith(color: highlightColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _launchUrl('mailto:$_emailAddress'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: bodyStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _emailAddress,
                    style: bodyStyle.copyWith(color: highlightColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm(TextStyle textStyle, Color highlightColor) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRequiredLabel('Name', textStyle, highlightColor),
          const SizedBox(height: 6),
          TextFormField(
            controller: _nameController,
            style: textStyle,
            cursorColor: const Color(0xFFfd6000),
            decoration: _inputDecoration('Your name'),
            validator:
                (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Name is required.'
                        : null,
          ),
          const SizedBox(height: 18),
          _buildRequiredLabel('Phone', textStyle, highlightColor),
          const SizedBox(height: 6),
          TextFormField(
            controller: _phoneController,
            style: textStyle,
            cursorColor: const Color(0xFFfd6000),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+ ]')),
            ],
            decoration: _inputDecoration('Phone number'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required.';
              }
              final sanitized = value.trim().replaceAll(' ', '');
              if (!RegExp(r'^\+?\d+$').hasMatch(sanitized)) {
                return 'Use digits only (plus and spaces allowed).';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          _buildRequiredLabel('Email', textStyle, highlightColor),
          const SizedBox(height: 6),
          TextFormField(
            controller: _emailController,
            style: textStyle,
            cursorColor: const Color(0xFFfd6000),
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration('Email address'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required.';
              }
              final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
              if (!emailPattern.hasMatch(value.trim())) {
                return 'Enter a valid email address.';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          _buildRequiredLabel('Message', textStyle, highlightColor),
          const SizedBox(height: 6),
          TextFormField(
            controller: _messageController,
            style: textStyle,
            cursorColor: const Color(0xFFfd6000),
            keyboardType: TextInputType.multiline,
            minLines: 7,
            maxLines: null,
            decoration: _inputDecoration('Your message'),
            validator:
                (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Message is required.'
                        : null,
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: _isSending ? null : _handleSend,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFfd6000),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:
                  _isSending
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : Text(
                        'Send',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequiredLabel(
    String label,
    TextStyle textStyle,
    Color highlightColor,
  ) {
    return RichText(
      text: TextSpan(
        style: textStyle.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        children: [
          TextSpan(text: label),
          TextSpan(text: ' *', style: TextStyle(color: highlightColor)),
        ],
      ),
    );
  }
}
