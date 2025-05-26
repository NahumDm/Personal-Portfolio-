import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Navbar extends StatelessWidget {
  final Function(int) onSectionSelected;

  const Navbar({super.key, required this.onSectionSelected});

  Future<void> _downloadResume() async {
    // Using view mode instead of edit mode for better download options
    const resumeUrl =
        'https://drive.google.com/file/d/1VwJsbl5rShc5f_EB2fMGgmdNuumqsKuz/view?usp=sharing';
    final uri = Uri.parse(resumeUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [_buildMobileNav()],
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _NavItem(title: 'Portfolio', onTap: () => onSectionSelected(0)),
        _NavItem(title: 'Education', onTap: () => onSectionSelected(1)),
        _NavItem(title: 'Contact', onTap: () => onSectionSelected(2)),
        _NavItem(title: 'Blog', onTap: () => onSectionSelected(3)),
        _NavItem(title: 'Resume', onTap: _downloadResume),
      ],
    );
  }

  Widget _buildMobileNav() {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.menu),
      itemBuilder:
          (context) => [
            const PopupMenuItem(value: 0, child: Text('Portfolio')),
            const PopupMenuItem(value: 1, child: Text('Education')),
            const PopupMenuItem(value: 2, child: Text('Contact')),
            const PopupMenuItem(value: 3, child: Text('Blog')),
            PopupMenuItem(
              value: 4,
              child: const Text('Resume'),
              onTap: () {
                // Use Future.delayed to ensure the popup menu is closed before launching the URL
                Future.delayed(Duration.zero, _downloadResume);
              },
            ),
          ],
      onSelected: (index) {
        if (index != 4) {
          // Only call onSectionSelected for non-resume items
          onSectionSelected(index);
        }
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
