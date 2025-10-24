import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialContactSection extends StatelessWidget {
  const SocialContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          icon: FontAwesomeIcons.github,
          color: const Color(0xFFffffff),
          onTap: () => _launchUrl('https://github.com/NahumDM'),
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: FontAwesomeIcons.linkedin,
          color: const Color(0xFFffffff),
          onTap:
              () => _launchUrl(
                'https://www.linkedin.com/in/nahom-desta-mengesha/',
              ),
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: FontAwesomeIcons.telegram,
          color: const Color(0xFFffffff),
          onTap: () => _launchUrl('https://t.me/NahumD'),
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: FontAwesomeIcons.xTwitter,
          color: Color(0xFFffffff),
          onTap: () => _launchUrl('https://twitter.com/DmNahum'),
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: FontAwesomeIcons.envelope,
          color: const Color(0xFFffffff),
          onTap: () => _launchUrl('mailto:nahomdestamg@gmail.com'),
        ),
      ],
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
            // Use the same low-contrast grey as the hero "Contact" label so
            // the icon background blends with the section.
            color: Colors.grey.withOpacity(0.1),
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
            scale: isHovered ? 1.9 : 1.4,
            // smaller icon size to match the requested design
            child: FaIcon(
              widget.icon,
              size: 15,
              color: isHovered ? const Color(0xFFfd6000) : widget.color,
            ),
          ),
        ),
      ),
    );
  }
}
