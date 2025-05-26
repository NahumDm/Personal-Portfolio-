import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/portfolio_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/blog_section.dart';
import '../widgets/education_section.dart';
import '../widgets/recognitions_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AutoScrollController _scrollController = AutoScrollController();
  final List<String> _sections = [
    'portfolio',
    'education',
    'contact',
    'blog',
    'resume',
  ];

  void _scrollToSection(int index) {
    _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    key: const ValueKey('portfolio'),
                    index: 0,
                    controller: _scrollController,
                    child: const PortfolioSection(),
                  ),
                  AutoScrollTag(
                    key: const ValueKey('education'),
                    index: 1,
                    controller: _scrollController,
                    child: const EducationSection(),
                  ),
                  const RecognitionsSection(),
                  AutoScrollTag(
                    key: const ValueKey('contact'),
                    index: 2,
                    controller: _scrollController,
                    child: const ContactSection(),
                  ),
                  AutoScrollTag(
                    key: const ValueKey('blog'),
                    index: 3,
                    controller: _scrollController,
                    child: const BlogSection(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
