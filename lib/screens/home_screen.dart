import 'package:flutter/material.dart';
import 'package:personal_portfolio/widgets/recognitions_section.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/portfolio_section.dart';
import '../widgets/education_section.dart';
import '../widgets/projects_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AutoScrollController _scrollController = AutoScrollController();

  void _scrollToSection(int index) {
    if (index == -1) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.begin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      body: Column(
        children: [
          Navbar(onSectionSelected: (index) => _scrollToSection(index)),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const HeroSection(),
                  AutoScrollTag(
                    key: const ValueKey('experience'),
                    index: 0,
                    controller: _scrollController,
                    child: const PortfolioSection(),
                  ),
                  AutoScrollTag(
                    key: const ValueKey('projects'),
                    index: 1,
                    controller: _scrollController,
                    child: const ProjectsSection(),
                  ),
                  AutoScrollTag(
                    key: const ValueKey('education'),
                    index: 2,
                    controller: _scrollController,
                    child: const EducationSection(),
                  ),
                  const RecognitionsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
