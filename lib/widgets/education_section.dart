import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navbar.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: isDarkMode ? Colors.black : Colors.white,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Education',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              _buildEducationCard(
                degree: 'Software Engineering Degree',
                institution: 'Arba Minch University',
                year: '2021 - Present',
                description:
                    'I\'m currently pursuing my Software Engineering degree at Arba Minch University, graduating in 2026. I\'ve grown through my leadership role in AMUECSF\s Education Department, leading bible studies, prayer times, and other activities.\nI also participate in the Student Peace Forum, where we promote peace, stability, and tolerance on campus. Additionally, I\m part of AMU TechHub, where I build projects, engage in hackathons, and connect with other aspiring developers. These experiences have helped me grow both as a student and as a community leader.',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 24),
              _buildEducationCard(
                degree: 'Management',
                institution: 'Arba Minch University',
                year: '2022 - Present',
                description: '''
While pursuing my Software Engineering degree at AMU, I'm also studying Management through a distance learning program. This allows me to broaden my knowledge in leadership and organizational principles alongside my technical skills.''',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 24),
              _buildEducationCard(
                degree: 'Advanced Backend Development',
                institution: 'ALX',
                year: 'Feb, 2025 - Present',
                description:
                    'I\m also currently enrolled in the Advanced Backend Development program at ALX Institute. It\s an intensive online course that not only hones my technical skills but also includes a professional foundation module to help improve my soft skills.\n We actively engage and discuss with peers to deepen our understanding, and we build various projects to apply what we learn. This hands-on approach ensures I\m developing both the technical and collaborative skills needed for success in the industry.',
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationCard({
    required String degree,
    required String institution,
    required String year,
    required String description,
    required bool isDarkMode,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Text(
            degree,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            institution,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            year,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
