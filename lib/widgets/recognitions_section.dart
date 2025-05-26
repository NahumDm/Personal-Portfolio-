import 'package:flutter/material.dart';

class RecognitionsSection extends StatelessWidget {
  const RecognitionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recognitions',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              _buildCertificatesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertificatesList() {
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
                  color: Colors.white,
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
                      
                          return Container(
                            height: 320,
                            color: Colors.grey[200],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Error loading image\n${error.toString()}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.red,
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
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
