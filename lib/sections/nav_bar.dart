import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NavBar extends StatelessWidget {
  final Function(String) onSectionTap;

  const NavBar({super.key, required this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      return _MobileNavBar(onSectionTap: onSectionTap);
    }
    return _DesktopNavBar(onSectionTap: onSectionTap);
  }
}

class _DesktopNavBar extends StatelessWidget {
  final Function(String) onSectionTap;

  const _DesktopNavBar({required this.onSectionTap});

  static const List<MapEntry<String, String>> _menuItems = [
    MapEntry('Home', 'home'),
    MapEntry('About', 'about'),
    MapEntry('Skills', 'skills'),
    MapEntry('Projects', 'projects'),
    MapEntry('Contact', 'contact'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Winfred Gatwiri',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _menuItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextButton(
                          onPressed: () => onSectionTap(item.value),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            item.key,
                            style: const TextStyle(
                              color: AppTheme.secondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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

class _MobileNavBar extends StatelessWidget {
  final Function(String) onSectionTap;

  const _MobileNavBar({required this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Winfred Gatwiri',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}