import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: const Color(0xFF232323),
      child: Center(
        child: SizedBox(
          // Match ProjectSection small-screen width usage (~90% of screen).
          // Keep original 70% for larger screens to preserve spacious layout.
          width:
              MediaQuery.of(context).size.width *
              (MediaQuery.of(context).size.width < 600 ? 0.9 : 0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isSmallScreen = constraints.maxWidth < 600;
                  return Text(
                    'Education',
                    style: GoogleFonts.montserrat(
                      fontSize: isSmallScreen ? 24 : 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              const _EducationCard(
                degree: 'Software Engineering Degree',
                institution: 'Arba Minch University',
                year: '2021 - Present',
                description:
                    'I\'m currently pursuing my Software Engineering degree at Arba Minch University, graduating in 2026. I\'ve grown through my leadership role in AMUECSF\'s Education Department, leading bible studies, prayer times, and other activities. I also participate in the Student Peace Forum, where we promote peace, stability, and tolerance on campus. Additionally, I\'m part of AMU TechHub, where I lead DSA Team & build projects, engage in hackathons, and connect with other aspiring developers. These experiences have helped me grow as a person, student and as a community leader.',
              ),
              const SizedBox(height: 24),
              const _EducationCard(
                degree: 'Business Management',
                institution: 'Arba Minch University',
                year: '2022 - Present',
                description:
                    'While pursuing my Software Engineering degree at AMU, I\'m also studying Management through a distance learning program. This allows me to broaden my knowledge in leadership and organizational principles alongside my technical skills.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EducationCard extends StatefulWidget {
  final String degree;
  final String institution;
  final String year;
  final String description;

  const _EducationCard({
    required this.degree,
    required this.institution,
    required this.year,
    required this.description,
  });

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _instHover = false;

  static final Uri _amuUri = Uri.parse('https://www.amu.edu.et/en/');

  Future<void> _openInstitution() async {
    if (!await launchUrl(_amuUri, mode: LaunchMode.externalApplication)) {
      // ignore: avoid_print
      print('Could not launch $_amuUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade600, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Institution first (clickable, underline on hover)
          MouseRegion(
            onEnter: (_) => setState(() => _instHover = true),
            onExit: (_) => setState(() => _instHover = false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _openInstitution,
              child: Container(
                padding: const EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _instHover ? Colors.white : Colors.transparent,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Text(
                  widget.institution,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Degree/department below institution
          Text(
            widget.degree,
            style: GoogleFonts.poppins(
              fontSize: 14,
              // ignore: deprecated_member_use
              color: const Color(0xFFf5f5f5).withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.year,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 12),
          Text(
            widget.description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFFD6D6D6),
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
