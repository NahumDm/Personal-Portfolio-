import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navbar.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      color: isDarkMode ? Colors.black : Colors.white,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 600;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isSmallScreen) ...[
                      _buildProfileImage(),
                      const SizedBox(height: 24),
                      _buildTextContent(isDarkMode),
                    ] else ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: _buildProfileImage(),
                            ),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: _buildTextContent(isDarkMode),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/image/nahomdesta.png',
          fit: BoxFit.fitHeight,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade200,
              child: const Icon(Icons.person, size: 70, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextContent(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello, I'm Nahom Desta",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              height: 1.5,
            ),
            children: [
              const TextSpan(
                text: '''
  — a passionate software engineer driven by the idea that technology can create meaningful change.
My journey began when I discovered I could build something from nothing and solve real societal problems. That spark led me to study software engineering at Arba Minch University and dive deep into mobile app design and development.\n
I've built efficient, user-friendly apps, and I'm constantly expanding my expertise beyond one technology. That's why I'm currently learning advanced backend development with ALX, and I'm planning to explore machine learning and robotics in the future to address even bigger challenges.\n
''',
              ),
              TextSpan(
                text: 'My mission is clear',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              const TextSpan(
                text:
                    ''': to relieve and solve local and African-focused problems by harnessing technology's power. I believe that mastering diverse tools and approaches will help me see — and solve — people's problems better.

''',
              ),
              TextSpan(
                text:
                    "Let's build a future where tech meets real-world impact.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
