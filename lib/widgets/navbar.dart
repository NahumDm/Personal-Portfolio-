import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Navbar extends StatelessWidget {
  final Function(int) onSectionSelected;

  const Navbar({super.key, required this.onSectionSelected});

  Future<void> _downloadResume() async {
    // Using view mode instead of edit mode for better download options
    const resumeUrl =
        'https://drive.google.com/file/d/1iMzI0oZWRU3MlY7ieQ9aRgAMl-kRqxbt/view?usp=sharing';
    final uri = Uri.parse(resumeUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF232323),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _NavItem(
                      title: 'Narke',
                      onTap: () => onSectionSelected(-1),
                    ),
                    _buildMobileNav(),
                  ],
                );
              } else {
                return _buildDesktopNav();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      children: [
        _NavItem(title: 'Narke', onTap: () => onSectionSelected(-1)),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 70),
              _NavItem(title: 'Experience', onTap: () => onSectionSelected(0)),
              const SizedBox(width: 60),
              _NavItem(title: 'Projects', onTap: () => onSectionSelected(1)),
              const SizedBox(width: 60),
              _NavItem(title: 'Education', onTap: () => onSectionSelected(2)),
              const SizedBox(width: 60),
              _NavItem(title: 'Contact', onTap: () => onSectionSelected(3)),
            ],
          ),
        ),
        _NavItem(title: 'Resume', onTap: _downloadResume),
      ],
    );
  }

  Widget _buildMobileNav() {
    return PopupMenuButton<int>(
      // ignore: deprecated_member_use
      icon: Icon(Icons.menu, color: const Color(0xFFFCEAFF).withOpacity(0.7)),
      color: const Color(0xFF232323),
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 0,
              child: Text(
                'Experience',
                style: GoogleFonts.montserrat(
                  // ignore: deprecated_member_use
                  color: const Color(0xFFFCEAFF).withOpacity(0.7),
                ),
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Text(
                'Projects',
                style: GoogleFonts.montserrat(
                  // ignore: deprecated_member_use
                  color: const Color(0xFFFCEAFF).withOpacity(0.7),
                ),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                'Education',
                style: GoogleFonts.montserrat(
                  // ignore: deprecated_member_use
                  color: const Color(0xFFFCEAFF).withOpacity(0.7),
                ),
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Text(
                'Contact',
                style: GoogleFonts.montserrat(
                  // ignore: deprecated_member_use
                  color: const Color(0xFFFCEAFF).withOpacity(0.7),
                ),
              ),
            ),
            PopupMenuItem(
              value: 4,
              child: Text(
                'Resume',
                style: GoogleFonts.montserrat(
                  // ignore: deprecated_member_use
                  color: const Color(0xFFFCEAFF).withOpacity(0.7),
                ),
              ),
              onTap: () {
                Future.delayed(Duration.zero, _downloadResume);
              },
            ),
          ],
      onSelected: (index) {
        if (index != 4) {
          onSectionSelected(index);
        }
      },
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({required this.title, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
      },
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isHovered ? 1.1 : 1.0,
              child: Text(
                widget.title,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                      isHovered
                          ? const Color(0xFFfd6000)
                          : const Color(0xFFe2ccff),
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  height: 2,
                  width:
                      _animation.value *
                      (widget.title.length * 8.0), // Approximate width
                  color: const Color(0xFFfd6000),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
