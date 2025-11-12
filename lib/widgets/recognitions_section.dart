import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecognitionsSection extends StatefulWidget {
  const RecognitionsSection({super.key});

  @override
  State<RecognitionsSection> createState() => _RecognitionsSectionState();
}

class _RecognitionsSectionState extends State<RecognitionsSection> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  bool _scrollingForward = true; // To track scroll direction
  double? _lastItemWidth;
  double? _lastGap;

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      color: const Color(0xFF232323),
      child: Center(
        child: SizedBox(
          width:
              MediaQuery.of(context).size.width *
              (MediaQuery.of(context).size.width < 600 ? 0.9 : 0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section heading matches Projects/Education styling.
              LayoutBuilder(
                builder: (context, constraints) {
                  final isSmallScreen = constraints.maxWidth < 600;
                  return Text(
                    'Recognitions',
                    style: GoogleFonts.montserrat(
                      fontSize: isSmallScreen ? 24 : 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 14),
              _buildCertificatesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertificatesList() {
    // Certificates data: asset path + label shown on hover.
    const certificates = <Map<String, String>>[
      {
        'image': 'assets/image/certificates/CursorHackathon.png',
        'title': 'Cursor Hackathon Participation',
      },
      {
        'image': 'assets/image/certificates/Voluntary.png',
        'title': 'Appreciation- Volunteer Teaching Service',
      },
      {
        'image': 'assets/image/certificates/alx.png',
        'title': 'ALX- AI-Career Essentials',
      },
      {
        'image': 'assets/image/certificates/PF.png',
        'title': 'ALX- Professional Foundation',
      },

      // Add more certificates as needed
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final double gap = isSmallScreen ? 12 : 16;
        final itemWidth =
            isSmallScreen
                ? constraints.maxWidth * 0.8
                : constraints.maxWidth / 3.2; // Approx. 3 images on desktop

        _configureAutoScroll(itemWidth, gap);

        // Outer container mimics Education card border with shared padding.
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade600, width: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 320,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: certificates.length,
              itemBuilder: (context, index) {
                final certificate = certificates[index];
                final margin = EdgeInsets.only(
                  right: index == certificates.length - 1 ? 0 : gap,
                );
                return _RecognitionCard(
                  width: itemWidth,
                  imagePath: certificate['image']!,
                  title: certificate['title']!,
                  isSmallScreen: isSmallScreen,
                  margin: margin,
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _configureAutoScroll(double itemWidth, double gap) {
    // Only recreate timer if parameters have changed
    if (_lastItemWidth == itemWidth && _lastGap == gap) {
      return;
    }

    _lastItemWidth = itemWidth;
    _lastGap = gap;

    // Cancel existing timer and create a new one with updated values
    _autoScrollTimer?.cancel();

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_scrollController.hasClients ||
          !_scrollController.position.hasContentDimensions) {
        return;
      }

      final maxExtent = _scrollController.position.maxScrollExtent;
      final currentPosition = _scrollController.offset;
      final singleItemExtent = itemWidth + gap;

      double targetOffset;

      if (_scrollingForward) {
        // If moving forward, calculate next position
        targetOffset = currentPosition + singleItemExtent;
        // When we reach or pass the end, reverse direction
        if (targetOffset >= maxExtent) {
          targetOffset = maxExtent;
          _scrollingForward = false;
        }
      } else {
        // If moving backward, calculate previous position
        targetOffset = currentPosition - singleItemExtent;
        // When we reach or pass the beginning, reverse direction
        if (targetOffset <= 0) {
          targetOffset = 0;
          _scrollingForward = true;
        }
      }

      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }
}

class _RecognitionCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final double width;
  final bool isSmallScreen;
  final EdgeInsetsGeometry margin;

  const _RecognitionCard({
    required this.imagePath,
    required this.title,
    required this.width,
    required this.isSmallScreen,
    required this.margin,
  });

  @override
  State<_RecognitionCard> createState() => _RecognitionCardState();
}

class _RecognitionCardState extends State<_RecognitionCard> {
  bool _isHovering = false;

  bool get _showLabel => widget.isSmallScreen || _isHovering;

  void _setHovering(bool value) {
    if (!widget.isSmallScreen) {
      setState(() => _isHovering = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(3);
    final scale = widget.isSmallScreen ? 1.0 : (_isHovering ? 1.05 : 1.0);

    return MouseRegion(
      onEnter: (_) => _setHovering(true),
      onExit: (_) => _setHovering(false),
      child: Container(
        width: widget.width,
        margin: widget.margin,
        decoration: BoxDecoration(
          // Each certificate has its own thin border for separation.
          borderRadius: borderRadius,
          border: Border.all(color: Colors.grey.shade600, width: 0.3),
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            children: [
              // Scales slightly on hover for desktop.
              Positioned.fill(
                child: AnimatedScale(
                  scale: scale,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedOpacity(
                      opacity: _showLabel ? 1 : 0,
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
