import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialContactSection extends StatelessWidget {
  final bool isSmall;
  const SocialContactSection({super.key, this.isSmall = false});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double spacing = isSmall ? 8.0 : 12.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          icon: FontAwesomeIcons.github,
          color: const Color(0xFFffffff),
          onTap: () => _launchUrl('https://github.com/NahumDM'),
          isSmall: isSmall,
        ),
        SizedBox(width: spacing),
        _SocialButton(
          icon: FontAwesomeIcons.linkedin,
          color: const Color(0xFFffffff),
          onTap:
              () => _launchUrl(
                'https://www.linkedin.com/in/nahom-desta-mengesha/',
              ),
          isSmall: isSmall,
        ),
        SizedBox(width: spacing),
        _SocialButton(
          icon: FontAwesomeIcons.telegram,
          color: const Color(0xFFffffff),
          onTap: () => _launchUrl('https://t.me/NahumD'),
          isSmall: isSmall,
        ),
        SizedBox(width: spacing),
        _SocialButton(
          icon: FontAwesomeIcons.xTwitter,
          color: const Color(0xFFffffff),
          onTap: () => _launchUrl('https://twitter.com/DmNahum'),
          isSmall: isSmall,
        ),
        SizedBox(width: spacing),
        _SocialButton(
          icon: FontAwesomeIcons.envelope,
          color: const Color(0xFFffffff),
          onTap: () => _launchUrl('mailto:nahomdestamg@gmail.com'),
          isSmall: isSmall,
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final bool isSmall;

  const _SocialButton({
    required this.icon,
    required this.onTap,
    required this.color,
    this.isSmall = false,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double padding = widget.isSmall ? 12.0 : 16.0;
    final double iconSize = widget.isSmall ? 12.0 : 15.0;
    final double hoverScale = widget.isSmall ? 1.5 : 1.9;
    final double initialScale = widget.isSmall ? 1.2 : 1.4;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
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
            scale: isHovered ? hoverScale : initialScale,
            child: FaIcon(
              widget.icon,
              size: iconSize,
              color: isHovered ? const Color(0xFFfd6000) : widget.color,
            ),
          ),
        ),
      ),
    );
  }
}
