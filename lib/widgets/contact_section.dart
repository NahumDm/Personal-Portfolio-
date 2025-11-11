import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static const String _phoneNumber = '+251 90 000 0000';
  static const String _emailAddress = 'nahomdestamg@gmail.com';
  static const String _location = 'Addis Ababa, Ethiopia / Remote';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
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

  void _handleSend() {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thanks for reaching out! I\'ll be in touch soon.'),
      ),
    );
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        color: Colors.white.withOpacity(0.6),
        fontSize: 14,
      ),
      filled: true,
      fillColor: const Color(0xFF2D2D2D),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
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

    final linkStyle = bodyStyle.copyWith(
      color: const Color(0xFFfd6000),
      decoration: TextDecoration.underline,
    );

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
                        linkStyle,
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(child: _buildForm(bodyStyle)),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIntroColumn(headingStyle, bodyStyle, linkStyle),
                  const SizedBox(height: 32),
                  _buildForm(bodyStyle),
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
    TextStyle linkStyle,
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
              child: Text('Phone: $_phoneNumber', style: linkStyle),
            ),
            const SizedBox(height: 12),
            Text('Address: $_location', style: bodyStyle),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _launchUrl('mailto:$_emailAddress'),
              child: Text('Email: $_emailAddress', style: linkStyle),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm(TextStyle textStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _nameController,
          style: textStyle,
          cursorColor: const Color(0xFFfd6000),
          decoration: _inputDecoration('Your name'),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: _phoneController,
          style: textStyle,
          cursorColor: const Color(0xFFfd6000),
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration('Phone number'),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: _emailController,
          style: textStyle,
          cursorColor: const Color(0xFFfd6000),
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration('Email address'),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: _messageController,
          style: textStyle,
          cursorColor: const Color(0xFFfd6000),
          keyboardType: TextInputType.multiline,
          minLines: 7,
          maxLines: null,
          decoration: _inputDecoration('Your message'),
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: _handleSend,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFfd6000),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Send',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
