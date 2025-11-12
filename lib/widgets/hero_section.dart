// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_portfolio/widgets/social_contact.dart';

class HeroSection extends StatelessWidget {
  // A stateless widget that displays the main hero section of the portfolio.
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Main container for the hero section.
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 28),
      color: const Color(0xFF232323),
      child: Center(
        child: SizedBox(
          // Constrains the width of the content.
          width: MediaQuery.of(context).size.width,
          child: LayoutBuilder(
            // Adapts the layout based on the screen size.
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 600;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Displays a different layout for small screens.
                    if (isSmallScreen) ...[
                      _buildProfileImage(isSmall: true),
                      const SizedBox(height: 24),
                      _buildTextContent(isSmall: true),
                    ] else ...[
                      // Displays a different layout for large screens.
                      Stack(
                        children: [
                          Column(
                            children: [
                              Center(child: _buildProfileImage(isSmall: false)),
                              const SizedBox(height: 36),
                              _buildTextContent(),
                            ],
                          ),
                          Positioned(
                            top: 100,
                            left: MediaQuery.of(context).size.width * 0.15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFfd6000),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "Hi, I'm Nahom Desta",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF232323),
                                ),
                              ),
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

  Widget _buildProfileImage({bool isSmall = false}) {
    // Builds the profile image with a circular border.
    // For small screens use a fixed size circle; for larger screens
    // use a FractionallySizedBox so the image fills ~90% of its column
    if (isSmall) {
      return AspectRatio(
        aspectRatio: 1.5,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Center(
            child: ClipOval(
              child: Image.asset(
                'assets/image/nahomdesta.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Displays a placeholder if the image fails to load.
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    }

    return FractionallySizedBox(
      widthFactor: 0.15, // occupy 15% of the container width
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/image/nahomdesta.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Displays a placeholder if the image fails to load.
                return Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.person, size: 70, color: Colors.grey),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent({bool isSmall = false}) {
    // Builds the text content of the hero section.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isSmall) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFfd6000),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              "Hi, I'm Nahom Desta",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF232323),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Full Stack Mobile App Developer ',
                style: GoogleFonts.poppins(
                  fontSize: isSmall ? 20 : 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFCEAFF),
                  shadows: [
                    Shadow(
                      offset: const Offset(-2, 2),
                      // ignore:
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 2,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '- iOS & Android',
                style: GoogleFonts.poppins(
                  fontSize: isSmall ? 20 : 28,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFFFCEAFF),
                  shadows: [
                    Shadow(
                      offset: const Offset(-2, 2),
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 2,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment:
              isSmall
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  'Contact',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 10),
                const SocialContactSection(isSmall: true),
              ],
            ),
            if (!isSmall)
              Column(
                children: [
                  Text(
                    'Location',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Addis Ababa, ET/Remote',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFFe2ccff),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
