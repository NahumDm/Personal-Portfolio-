import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Experience {
  final String duration;
  final String logoPath;
  final String title;
  final String company;
  final String description;
  final List<String> responsibilities;
  final String url;

  const Experience({
    required this.duration,
    required this.logoPath,
    required this.title,
    required this.company,
    required this.description,
    required this.responsibilities,
    required this.url,
  });
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    const experiences = <Experience>[
      Experience(
        duration: 'Feb 2025 – July 2025',
        logoPath: 'assets/image/logo/ssgi-logo.jpg', // Placeholder logo
        title: 'Frontend Dev',
        company: 'Space Science and Geospatial Institute',
        description:
            'A government research institute focused on aerospace, remote sensing, and geospatial sciences in Ethiopia.',
        responsibilities: [
          'Led the development of a cross-platform mobile application using Flutter for internal failure reporting & maintenance tracking system.',
          'Collaborated with administrative and research teams to gather requirements and ensure the app met user needs.',
          'Implemented a responsive UI to ensure a seamless experience on both mobile and tablet devices.',
        ],
        url: 'https://www.ssgi.gov.et/',
      ),
      // Add more experiences here
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 24,
        vertical: 80,
      ),
      color: const Color(0xFF232323),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isSmallScreen ? double.infinity : 1000,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Experience',
                style: GoogleFonts.montserrat(
                  fontSize: isSmallScreen ? 24 : 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              ...experiences.map(
                (exp) => _ExperienceTimelineEntry(experience: exp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceTimelineEntry extends StatefulWidget {
  final Experience experience;

  const _ExperienceTimelineEntry({required this.experience});

  @override
  State<_ExperienceTimelineEntry> createState() =>
      _ExperienceTimelineEntryState();
}

class _ExperienceTimelineEntryState extends State<_ExperienceTimelineEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
      if (_isHovered) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          if (isMobile) {
            // Vertical layout for mobile
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDurationBadge(),
                const SizedBox(height: 16),
                // Push the entire content (logo, title, description, responsibilities) to the right
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: _buildExperienceCard(isMobile: true),
                ),
              ],
            );
          } else {
            // Horizontal layout for desktop
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 120, child: _buildDurationBadge()),
                Expanded(
                  child: CustomPaint(
                    painter: _TimelinePainter(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: _buildExperienceCard(isMobile: false),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDurationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2d2d2d),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        widget.experience.duration,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildExperienceCard({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile)
          // Mobile layout: Icon, then Title/Company below
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLogo(),
              const SizedBox(height: 16),
              _buildTitleAndCompany(),
            ],
          )
        else
          // Desktop layout: Icon and Title/Company in a row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLogo(),
              const SizedBox(width: 16),
              Expanded(child: _buildTitleAndCompany()),
            ],
          ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            widget.experience.description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color:
                  _isHovered
                      ? const Color(0xFFf5f5f5)
                      : const Color(0xFFD6D6D6),
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...widget.experience.responsibilities.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '› ',
                  style: TextStyle(
                    color: Color(0xFFf5f5f5),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    point,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color:
                          _isHovered
                              ? const Color(0xFFf5f5f5)
                              : const Color(0xFFD6D6D6),
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(widget.experience.url),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              widget.experience.logoPath,
              width: 48,
              height: 48,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndCompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.experience.title,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          widget.experience.company,
          style: GoogleFonts.poppins(
            fontSize: 14,
            // ignore: deprecated_member_use
            color: const Color(0xFFf5f5f5).withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

class _TimelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 1;

    const double dashHeight = 3.0;
    const double dashSpace = 4.0;
    double startY = 24; // Start below the badge

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
