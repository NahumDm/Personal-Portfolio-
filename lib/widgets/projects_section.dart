// Renders the Projects section with responsive cards and animated hover borders.
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/project.dart';

// Top-level Projects section widget
class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: const Color(0xFF232323),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isSmallScreen = constraints.maxWidth < 600;
                  return Text(
                    'Projects',
                    style: GoogleFonts.montserrat(
                      fontSize: isSmallScreen ? 24 : 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              _buildProjectList(),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the list of project cards (data + mapping to widgets)
  Widget _buildProjectList() {
    const projects = <Project>[
      Project(
        title: 'SSGI-Fix',
        description:
            'SSGI-FIX is a smart maintenance and failure reporting app developed for the Ethiopian Space Science and Geospatial Institute. It allows users to report issues, assign jobs, and monitor progress in real time. With integrated chat, analytics dashboards, and AI assistance, the app enhances team coordination, streamlines repair workflows, and promotes data-driven maintenance decisions.',
        imagePath: 'assets/image/projects/ssgi-image.png',
        liveUrl: '',
        sourceCodeUrl: '',
        techStack: [
          TechStackItem(
            label: 'Flutter',
            assetPath: 'assets/image/tech_logo/icons8-flutter.svg',
          ),
          TechStackItem(
            label: 'Firebase',
            assetPath: 'assets/image/tech_logo/icons8-firebase.svg',
          ),
        ],
        cardHeight: 230,
      ),
      Project(
        title: 'ዳውሮኛ ተረትና ምሳሌ',
        description:
            'The Dawurogna Proverb App preserves and promotes Dawuro culture through a curated collection of traditional proverbs. It features a clean, intuitive interface where users can explore, read, and share sayings that reflect the community’s wisdom, humor, and values. Designed as a cultural archive, it connects modern audiences with Dawuro heritage.',
        imagePath: 'assets/image/projects/Dawurogna_Proverb.png',
        liveUrl:
            'https://github.com/NahumDm/Dawurogna-figurative-speaking/releases/tag/dawuro-proverb',
        sourceCodeUrl:
            'https://github.com/NahumDm/Dawurogna-figurative-speaking',
        techStack: [
          TechStackItem(
            label: 'Flutter',
            assetPath: 'assets/image/tech_logo/icons8-flutter.svg',
          ),
        ],
        cardHeight: 230,
      ),
      // Additional projects can be added here
    ];

    return Column(
      children:
          projects
              .map(
                (project) => Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _ProjectCard(project: project),
                ),
              )
              .toList(),
    );
  }
}

// Single project card with hover-driven border animation
class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  // Hover flag (desktop/web) to animate border color/width
  bool _hover = false;

  bool get _hasLive =>
      widget.project.liveUrl != null &&
      widget.project.liveUrl!.trim().isNotEmpty;
  bool get _hasSource =>
      widget.project.sourceCodeUrl != null &&
      widget.project.sourceCodeUrl!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    // MouseRegion toggles hover; LayoutBuilder decides mobile vs desktop layout
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 600;
          final double? cardHeight = widget.project.cardHeight;
          // Mobile: Column; Desktop: Row wrapped in IntrinsicHeight so image/content bottoms align
          final Widget card =
              isSmall
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImage(isSmall: true, cardHeight: cardHeight),
                      const SizedBox(height: 7),
                      _buildContent(isSmall: true, cardHeight: null),
                    ],
                  )
                  : (() {
                    final row = Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildImage(
                            isSmall: false,
                            cardHeight: cardHeight,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 7,
                          child: _buildContent(
                            isSmall: false,
                            cardHeight: cardHeight,
                          ),
                        ),
                      ],
                    );
                    final intrinsic = IntrinsicHeight(child: row);
                    return cardHeight != null
                        ? SizedBox(height: cardHeight, child: intrinsic)
                        : intrinsic;
                  })();

          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: card,
          );
        },
      ),
    );
  }

  // Project image container: thin grey border -> thicker #F7F3ED on hover
  Widget _buildImage({required bool isSmall, double? cardHeight}) {
    final border = Border.all(
      color: _hover ? const Color(0xFFF7F3ED) : Colors.grey.shade600,
      width: _hover ? 2.0 : 0.1,
    );
    final bool isDawurogna = widget.project.title == 'ዳውሮኛ ተረትና ምሳሌ';
    if (isSmall) {
      // Mobile uses fixed 220px height image
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          border: border,
          color: isDawurogna ? Colors.white : null,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: Image.asset(
            widget.project.imagePath,
            fit: BoxFit.cover,
            height: 220,
            width: double.infinity,
          ),
        ),
      );
    }
    // Desktop/tablet: let image height expand to match content via IntrinsicHeight
    Widget image = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: border,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        color: isDawurogna ? Colors.white : null,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        child: SizedBox.expand(
          child: Image.asset(
            widget.project.imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );

    if (cardHeight != null) {
      image = SizedBox(height: cardHeight, child: image);
    }

    return image;
  }

  // Project content: title, description, actions, and tech icons
  Widget _buildContent({required bool isSmall, double? cardHeight}) {
    final descriptionText = Text(
      widget.project.description,
      style: GoogleFonts.inter(
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.w400,
        color: _hover ? const Color(0xFFf5f5f5) : const Color(0xFFD6D6D6),
      ),
    );

    final bool constrainHeight = !isSmall && cardHeight != null;

    final columnChildren = <Widget>[
      Text(
        widget.project.title,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 16),
      if (constrainHeight)
        Expanded(child: SingleChildScrollView(child: descriptionText))
      else
        descriptionText,
      const SizedBox(height: 12),
      _actionsAndTechRow(isSmall: isSmall),
    ];

    Widget contentColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: constrainHeight ? MainAxisSize.max : MainAxisSize.min,
      children: columnChildren,
    );

    Widget wrapped = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: Border.all(
          color: _hover ? const Color(0xFFF7F3ED) : Colors.grey.shade600,
          width: _hover ? 1.0 : 0.5,
        ),
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
          topLeft:
              isSmall ? const Radius.circular(12) : const Radius.circular(0),
          bottomLeft:
              isSmall ? const Radius.circular(12) : const Radius.circular(0),
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(18), child: contentColumn),
    );

    if (constrainHeight) {
      wrapped = SizedBox(height: cardHeight, child: wrapped);
    }

    return wrapped;
  }

  // Small badge indicating NDA-protected project
  Widget _ndaBadge() {
    // Match 'View Live' outlined button style (outline, font, size)
    return IgnorePointer(
      ignoring: true,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onPressed: () {},
        icon: const Icon(Icons.lock, color: Colors.white, size: 18),
        label: const Text(
          'NDA Protected',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Renders "View Live" and "Source Code" if URLs are provided
  Widget _actionButtons({required bool isSmall}) {
    final buttons = <Widget>[
      if (_hasLive)
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onPressed: () => _launchUrl(widget.project.liveUrl!),
          icon: const Icon(Icons.launch, color: Colors.white, size: 18),
          label: const Text('View Live', style: TextStyle(color: Colors.white)),
        ),
      if (_hasSource)
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onPressed: () => _launchUrl(widget.project.sourceCodeUrl!),
          icon: const Icon(Icons.code, color: Colors.white, size: 18),
          label: const Text(
            'Source Code',
            style: TextStyle(color: Colors.white),
          ),
        ),
    ];

    if (buttons.isEmpty) {
      return const SizedBox.shrink();
    }

    return isSmall
        ? Wrap(spacing: 12, runSpacing: 12, children: buttons)
        : Row(children: _withSpacing(buttons, gap: 16));
  }

  List<Widget> _withSpacing(List<Widget> children, {double gap = 8}) {
    final spaced = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      spaced.add(children[i]);
      if (i != children.length - 1) spaced.add(SizedBox(width: gap));
    }
    return spaced;
  }

  // Icons previewing the technologies used for the project
  Widget _techRow() {
    if (widget.project.techStack.isEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < widget.project.techStack.length; i++) ...[
          Tooltip(
            message: widget.project.techStack[i].label,
            child: SvgPicture.asset(
              widget.project.techStack[i].assetPath,
              width: 22,
              height: 22,
            ),
          ),
          if (i != widget.project.techStack.length - 1)
            const SizedBox(width: 12),
        ],
      ],
    );
  }

  // Renders NDA badge or action buttons on the left, tech stack icons on the right (desktop),
  // or stacked (mobile).
  Widget _actionsAndTechRow({required bool isSmall}) {
    final Widget left =
        widget.project.title == 'SSGI-Fix'
            ? _ndaBadge()
            : _actionButtons(isSmall: isSmall);
    final Widget right = _techRow();

    final bool hasRight = widget.project.techStack.isNotEmpty;

    if (isSmall) {
      // Stack on small screens to avoid overflow
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          left,
          if (hasRight) const SizedBox(height: 12),
          if (hasRight) Align(alignment: Alignment.centerRight, child: right),
        ],
      );
    }

    // Desktop/tablet: share a single row, left item then icons aligned right
    return Row(
      children: [
        // Left content (NDA badge or buttons); Expanded lets Spacer/Right align correctly
        Flexible(flex: 0, child: left),
        const Spacer(),
        if (hasRight) right,
      ],
    );
  }

  // Opens a URL in an external application (e.g., browser)
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // ignore: avoid_print
      print('Could not launch $url');
    }
  }
}
