import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({
    super.key,
    required this.role,
    required this.child,
  });

  final AuthRole role;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar:
          role == AuthRole.patient ? const _PatientNavBar() : const _MedecinNavBar(),
    );
  }
}

// ─── Patient Navigation ──────────────────────────────────────────────────────

class _PatientNavBar extends StatelessWidget {
  const _PatientNavBar();

  static const _items = [
    (
      label: 'Accueil',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      route: AppRoutes.patientDashboard,
    ),
    (
      label: 'Carnet',
      icon: Icons.history_edu_outlined,
      activeIcon: Icons.history_edu_rounded,
      route: AppRoutes.patientHistory,
    ),
    (
      label: 'Accès',
      icon: Icons.shield_outlined,
      activeIcon: Icons.shield_rounded,
      route: AppRoutes.patientAccess,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _items.indexWhere((i) => location.startsWith(i.route));

    return _GlassNavBar(
      selectedIndex: currentIndex < 0 ? 0 : currentIndex,
      color: AppColors.patientColor,
      items: _items
          .map(
            (e) => _NavItem(
              label: e.label,
              icon: e.icon,
              activeIcon: e.activeIcon,
            ),
          )
          .toList(),
      onTap: (i) => context.go(_items[i].route),
    );
  }
}

// ─── Medecin Navigation ──────────────────────────────────────────────────────

class _MedecinNavBar extends StatelessWidget {
  const _MedecinNavBar();

  static const _items = [
    (
      label: 'Tableau de bord',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard_rounded,
      route: AppRoutes.medecinDashboard,
    ),
    (
      label: 'Recherche',
      icon: Icons.search_outlined,
      activeIcon: Icons.search_rounded,
      route: AppRoutes.medecinSearch,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _items.indexWhere((i) => location.startsWith(i.route));

    return _GlassNavBar(
      selectedIndex: currentIndex < 0 ? 0 : currentIndex,
      color: AppColors.medecinColor,
      items: _items
          .map(
            (e) => _NavItem(
              label: e.label,
              icon: e.icon,
              activeIcon: e.activeIcon,
            ),
          )
          .toList(),
      onTap: (i) => context.go(_items[i].route),
    );
  }
}

// ─── Glassmorphic Nav Bar ─────────────────────────────────────────────────────

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
  final String label;
  final IconData icon;
  final IconData activeIcon;
}

class _GlassNavBar extends StatelessWidget {
  const _GlassNavBar({
    required this.selectedIndex,
    required this.items,
    required this.onTap,
    required this.color,
  });

  final int selectedIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withAlpha(15)
                  : Colors.white.withAlpha(200),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: isDark
                    ? Colors.white.withAlpha(30)
                    : Colors.white.withAlpha(180),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: color.withAlpha(15),
                  blurRadius: 32,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (i) {
                final isSelected = i == selectedIndex;
                final item = items[i];
                return _NavBarItem(
                  label: item.label,
                  icon: item.icon,
                  activeIcon: item.activeIcon,
                  isSelected: isSelected,
                  activeColor: color,
                  isDark: isDark,
                  onTap: () => onTap(i),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  const _NavBarItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.isSelected,
    required this.activeColor,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final bool isSelected;
  final Color activeColor;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.isSelected ? 1 : 0,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.0).animate(_controller);
  }

  @override
  void didUpdateWidget(_NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inactiveColor = widget.isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? widget.activeColor.withAlpha(20)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, anim) => ScaleTransition(
                scale: anim,
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: Icon(
                widget.isSelected ? widget.activeIcon : widget.icon,
                key: ValueKey(widget.isSelected),
                color: widget.isSelected ? widget.activeColor : inactiveColor,
                size: 26,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 10,
                fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w400,
                color: widget.isSelected ? widget.activeColor : inactiveColor,
              ),
              child: Text(widget.label),
            ),
          ],
        ),
      ),
    );
  }
}
