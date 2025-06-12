import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class Navbar extends StatelessWidget {
  final Function(int) onSectionSelected;

  const Navbar({super.key, required this.onSectionSelected});

  Future<void> _downloadResume() async {
    // Using view mode instead of edit mode for better download options
    const resumeUrl =
        'https://drive.google.com/file/d/1SOKFW6aIhTfddcV5po3V6MHODGkbUnG_/view?usp=drive_link';
    final uri = Uri.parse(resumeUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildMobileNav(isDarkMode), _buildThemeToggle()],
                );
              } else {
                return _buildDesktopNav(isDarkMode);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNav(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _NavItem(
          title: 'Portfolio',
          onTap: () => onSectionSelected(0),
          isDarkMode: isDarkMode,
        ),
        _NavItem(
          title: 'Education',
          onTap: () => onSectionSelected(1),
          isDarkMode: isDarkMode,
        ),
        _NavItem(
          title: 'Contact',
          onTap: () => onSectionSelected(2),
          isDarkMode: isDarkMode,
        ),
        _NavItem(
          title: 'Blog',
          onTap: () => onSectionSelected(3),
          isDarkMode: isDarkMode,
        ),
        _NavItem(
          title: 'Resume',
          onTap: _downloadResume,
          isDarkMode: isDarkMode,
        ),
        _buildThemeToggle(),
      ],
    );
  }

  Widget _buildMobileNav(bool isDarkMode) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.menu, color: isDarkMode ? Colors.white : Colors.black),
      color: isDarkMode ? Colors.grey.shade900 : Colors.white,
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 0,
              child: Text(
                'Portfolio',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Text(
                'Education',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                'Contact',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Text(
                'Blog',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            PopupMenuItem(
              value: 4,
              child: Text(
                'Resume',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
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

  Widget _buildThemeToggle() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return IconButton(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            themeProvider.toggleTheme();
          },
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isDarkMode;

  const _NavItem({
    required this.title,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
