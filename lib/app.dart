import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/section_title.dart';
import 'sections/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winfred Gatwiri \u2014 Mobile & Flutter Application Developer',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(String section) {
    GlobalKey? key;
    switch (section) {
      case 'home':
        key = _homeKey;
        break;
      case 'about':
        key = _aboutKey;
        break;
      case 'skills':
        key = _skillsKey;
        break;
      case 'projects':
        key = _projectsKey;
        break;
      case 'contact':
        key = _contactKey;
        break;
    }
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      endDrawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: AppTheme.primary),
                    child: Text(
                      'Winfred Gatwiri',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _drawerItem('Home', 'home'),
                  _drawerItem('About', 'about'),
                  _drawerItem('Skills', 'skills'),
                  _drawerItem('Projects', 'projects'),
                  _drawerItem('Contact', 'contact'),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(onSectionTap: _scrollToSection),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionWrapper(
                      key: _homeKey,
                      child: HeroSection(
                        onViewProjects: () => _scrollToSection('projects'),
                        onContactMe: () => _scrollToSection('contact'),
                      ),
                    ),
                    _sectionWrapper(
                      key: _aboutKey,
                      title: 'About',
                      child: AboutSection(
                        onAppSelected: (_) => _scrollToSection('projects'),
                      ),
                    ),
                    _sectionWrapper(
                      key: _skillsKey,
                      title: 'Skills',
                      child: const SkillsSection(),
                    ),
                    _sectionWrapper(
                      key: _projectsKey,
                      title: 'Featured Mobile Projects',
                      child: const ProjectsSection(),
                    ),
                    _sectionWrapper(
                      key: _contactKey,
                      title: 'Contact',
                      child: const ContactSection(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: FooterSection(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String label, String section) {
    return ListTile(
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        _scrollToSection(section);
      },
    );
  }

  Widget _sectionWrapper({
    Key? key,
    String? title,
    required Widget child,
  }) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            SectionTitle(title: title),
            const SizedBox(height: 32),
          ],
          child,
        ],
      ),
    );
  }
}