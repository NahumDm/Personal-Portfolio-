import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: const Color(0xFF232323),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Projects',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              _buildProjectList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectList() {
    final projects = [
      Project(
        title: 'SSGI-Fix',
        description:
            '''A Flutter-based mobile app for the Space Science and Geospatial Institute of Ethiopia, streamlining failure reporting and user management for administrative and research teams.\nBuilt with Flutter and Firebase technologies.''',
        imagePath: 'assets/image/ssgi-image.png',
        liveUrl: '',
        sourceCodeUrl: '',
      ),
      // Add more projects here
    ];

    return Column(
      children:
          projects.map((project) {
            return Column(
              children: [
                _ProjectCard(project: project),
                const SizedBox(height: 30),
              ],
            );
          }).toList(),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child:
              isSmallScreen
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildImage(), _buildContent()],
                  )
                  : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _buildImage()),
                      Expanded(flex: 7, child: _buildContent()),
                    ],
                  ),
        );
      },
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: Image.asset(
        project.imagePath,
        fit: BoxFit.cover,
        height: 220,
        width: double.infinity,
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade300,
                height: 1.5,
                fontFamily: 'Open Sans',
              ),
              children: [
                TextSpan(text: project.description),
                const TextSpan(text: '\n\n'),
                const TextSpan(
                  text: '- Implemented responsive and user-friendly interface',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (project.title == 'SSGI-Fix')
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lock,
                              size: 16,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'NDA Protected',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    else ...[
                      if (project.liveUrl != null)
                        _ActionButton(
                          label: 'View Live',
                          icon: Icons.launch,
                          onTap: () => _launchUrl(project.liveUrl!),
                        ),
                      if (project.liveUrl != null &&
                          project.sourceCodeUrl != null)
                        const SizedBox(height: 16),
                      if (project.sourceCodeUrl != null)
                        _ActionButton(
                          label: 'Source Code',
                          icon: Icons.code,
                          onTap: () => _launchUrl(project.sourceCodeUrl!),
                        ),
                    ],
                  ],
                );
              } else {
                return Row(
                  children: [
                    if (project.title == 'SSGI-Fix')
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lock,
                              size: 16,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'NDA Protected',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    else ...[
                      if (project.liveUrl != null)
                        _ActionButton(
                          label: 'View Live',
                          icon: Icons.launch,
                          onTap: () => _launchUrl(project.liveUrl!),
                        ),
                      if (project.liveUrl != null &&
                          project.sourceCodeUrl != null)
                        const SizedBox(width: 16),
                      if (project.sourceCodeUrl != null)
                        _ActionButton(
                          label: 'Source Code',
                          icon: Icons.code,
                          onTap: () => _launchUrl(project.sourceCodeUrl!),
                        ),
                    ],
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade400),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
