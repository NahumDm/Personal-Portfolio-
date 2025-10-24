import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contact',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 32),
              _buildSocialIcons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        if (isMobile) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(
                    icon: FontAwesomeIcons.github,
                    color: const Color(0xFF333333),
                    onTap: () => _launchUrl('https://github.com/nahomdesta'),
                  ),
                  const SizedBox(width: 32),
                  _SocialButton(
                    icon: FontAwesomeIcons.linkedin,
                    color: const Color(0xFF0077B5),
                    onTap:
                        () => _launchUrl(
                          'https://www.linkedin.com/in/nahom-desta/',
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(
                    icon: FontAwesomeIcons.telegram,
                    color: const Color(0xFF0088CC),
                    onTap: () => _launchUrl('https://t.me/NahumD'),
                  ),
                  const SizedBox(width: 32),
                  _SocialButton(
                    icon: FontAwesomeIcons.xTwitter,
                    color: Colors.black,
                    onTap: () => _launchUrl('https://twitter.com/NahumDM'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(
                    icon: FontAwesomeIcons.envelope,
                    color: const Color(0xFFEA4335),
                    onTap: () => _launchUrl('mailto:nahomdesta@gmail.com'),
                  ),
                ],
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(
              icon: FontAwesomeIcons.github,
              color: const Color(0xFF333333),
              onTap: () => _launchUrl('https://github.com/NahumDM'),
            ),
            const SizedBox(width: 32),
            _SocialButton(
              icon: FontAwesomeIcons.linkedin,
              color: const Color(0xFF0077B5),
              onTap:
                  () => _launchUrl(
                    'https://www.linkedin.com/in/nahom-desta-mengesha/',
                  ),
            ),
            const SizedBox(width: 32),
            _SocialButton(
              icon: FontAwesomeIcons.telegram,
              color: const Color(0xFF0088CC),
              onTap: () => _launchUrl('https://t.me/NahumD'),
            ),
            const SizedBox(width: 32),
            _SocialButton(
              icon: FontAwesomeIcons.xTwitter,
              color: Colors.black,
              onTap: () => _launchUrl('https://twitter.com/DmNahum'),
            ),
            const SizedBox(width: 32),
            _SocialButton(
              icon: FontAwesomeIcons.envelope,
              color: const Color(0xFFEA4335),
              onTap: () => _launchUrl('mailto:nahomdestamg@gmail.com'),
            ),
          ],
        );
      },
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _SocialButton({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: isHovered ? 1.2 : 1.0,
            child: FaIcon(widget.icon, size: 24, color: widget.color),
          ),
        ),
      ),
    );
  }
}
