import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navbar.dart';

class RecognitionsSection extends StatelessWidget {
  const RecognitionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      color: isDarkMode ? Colors.black : Colors.white,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recognitions',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              _buildCertificatesList(isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertificatesList(bool isDarkMode) {
    // Local images
    final certificates = [
      {
        'image': 'assets/image/certificates/Voluntary.png',
        'title': 'Certificate of Appreciation - Volunteer Teaching Service',
      },
      {
        'image': 'assets/image/certificates/alx.png',
        'title': 'ALX - Certificate of AI-Career Essentials',
      },
      {
        'image': 'assets/image/certificates/PF.png',
        'title': 'ALX - Certificate of Professional Foundation',
      },

      // Add more certificates as needed
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            constraints.maxWidth < 600
                ? constraints.maxWidth *
                    0.8 // Show 1 image on mobile
                : constraints.maxWidth / 3.2; // Show 3 images on desktop

        return SizedBox(
          height: 395,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: certificates.length,
            itemBuilder: (context, index) {
              return Container(
                width: itemWidth,
                margin: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.asset(
                        certificates[index]['image']!,
                        width: double.infinity,
                        height: 320,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          print(
                            'Error loading image: ${error.toString()}',
                          ); // Add debug print
                          return Container(
                            height: 320,
                            color:
                                isDarkMode
                                    ? Colors.grey.shade800
                                    : Colors.grey[200],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color:
                                      isDarkMode
                                          ? Colors.red.shade300
                                          : Colors.red,
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Error loading image\n${error.toString()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        isDarkMode
                                            ? Colors.red.shade300
                                            : Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        certificates[index]['title']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
