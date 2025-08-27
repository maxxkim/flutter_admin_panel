// In file: admin_shell_page.dart

import 'package:auto_route/auto_route.dart';
import 'package:clean_arch_app/core/router/app_router.gr.dart';
import 'package:clean_arch_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

@RoutePage()
class AdminShellPage extends ConsumerStatefulWidget {
  const AdminShellPage({super.key});

  @override
  ConsumerState<AdminShellPage> createState() => _AdminShellPageState();
}

class _AdminShellPageState extends ConsumerState<AdminShellPage> {
  bool _isCollapsed = false;

  final List<SidebarItem> _menuItems = [
    SidebarItem(
      title: 'Dashboard',
      icon: LucideIcons.layoutDashboard,
      route: const DashboardRoute(),
    ),
    SidebarItem(
      title: 'Пользователи',
      icon: LucideIcons.users,
      route: const UsersListRoute(),
      badge: '1.2k',
    ),
    /* SidebarItem(
      title: 'Чеки',
      icon: LucideIcons.receipt,
      route: const ChecksListRoute(),
      badge: '32',
      badgeColor: Colors.orange,
    ),
    SidebarItem(
      title: 'Бонусы',
      icon: LucideIcons.gift,
      route: const BonusesListRoute(),
    ),
    SidebarItem(
      title: 'Операции',
      icon: LucideIcons.arrowLeftRight,
      route: const OperationsListRoute(),
    ),
    SidebarItem(
      title: 'Магазины',
      icon: LucideIcons.store,
      route: const ShopsListRoute(),
    ),
    SidebarItem(
      title: 'Push-уведомления',
      icon: LucideIcons.bell,
      route: const PushListRoute(),
      badge: '5',
      badgeColor: Colors.red,
    ), */
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return AutoTabsRouter(
      routes: const [
        DashboardRoute(),
        UsersListRoute(),
        /* ChecksListRoute(),
        BonusesListRoute(),
        OperationsListRoute(),
        ShopsListRoute(),
        PushListRoute(),
        SettingsRoute(), */
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          // Use a proper AppBar for the top bar
          appBar: isMobile
              ? AppBar(
                  title: const Text('Admin Panel'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: const Icon(LucideIcons.bell),
                      onPressed: () {},
                    ),
                  ],
                )
              : null,
          // Use a proper Drawer for mobile navigation
          drawer: isMobile
              ? Drawer(
                  child: _Sidebar(
                    isCollapsed: false,
                    menuItems: _menuItems,
                    selectedIndex: tabsRouter.activeIndex,
                    onItemTap: (index) {
                      tabsRouter.setActiveIndex(index);
                      Navigator.of(context).pop(); // Close the drawer
                    },
                    onCollapseToggle: () {},
                    onSettingsTap: () {
                      tabsRouter.setActiveIndex(7);
                      Navigator.of(context).pop(); // Close the drawer
                    },
                    isDarkMode: isDarkMode,
                    onThemeToggle: () {
                      ref.read(themeProvider.notifier).state = !isDarkMode;
                    },
                  ),
                )
              : null,
          body: Row(
            children: [
              // Sidebar for desktop/tablet
              if (!isMobile)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isCollapsed ? 80 : 260,
                  child: _Sidebar(
                    isCollapsed: _isCollapsed,
                    menuItems: _menuItems,
                    selectedIndex: tabsRouter.activeIndex,
                    onItemTap: (index) => tabsRouter.setActiveIndex(index),
                    onCollapseToggle: () {
                      setState(() => _isCollapsed = !_isCollapsed);
                    },
                    onSettingsTap: () => tabsRouter.setActiveIndex(7),
                    isDarkMode: isDarkMode,
                    onThemeToggle: () {
                      ref.read(themeProvider.notifier).state = !isDarkMode;
                    },
                  ),
                ),
              // Main content
              Expanded(
                child: Column(
                  children: [
                    // The custom TopBar is now replaced by the AppBar above
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Add the missing class definitions here

class _Sidebar extends StatelessWidget {
  final bool isCollapsed;
  final List<SidebarItem> menuItems;
  final int selectedIndex;
  final Function(int) onItemTap;
  final VoidCallback onCollapseToggle;
  final VoidCallback onSettingsTap;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const _Sidebar({
    required this.isCollapsed,
    required this.menuItems,
    required this.selectedIndex,
    required this.onItemTap,
    required this.onCollapseToggle,
    required this.onSettingsTap,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        border: Border(
          right: BorderSide(
            color: theme.dividerColor.withOpacity(0.1),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (!isCollapsed) ...[
                  Icon(
                    LucideIcons.shield,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Admin Panel',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const Spacer(),
                IconButton(
                  icon: Icon(
                    isCollapsed ? LucideIcons.panelLeftOpen : LucideIcons.panelLeftClose,
                    size: 20,
                  ),
                  onPressed: onCollapseToggle,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = selectedIndex == index;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Material(
                    color: isSelected
                      ? theme.colorScheme.primary.withOpacity(0.1)
                      : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () => onItemTap(index),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isCollapsed ? 12 : 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              size: 20,
                              color: isSelected
                                ? theme.colorScheme.primary
                                : theme.iconTheme.color?.withOpacity(0.6),
                            ),
                            if (!isCollapsed) ...[
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                    color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.textTheme.bodyLarge?.color,
                                    fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (item.badge != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: item.badgeColor ?? theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item.badge!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _SidebarButton(
                  icon: isDarkMode ? LucideIcons.sun : LucideIcons.moon,
                  title: isDarkMode ? 'Светлая тема' : 'Темная тема',
                  isCollapsed: isCollapsed,
                  onTap: onThemeToggle,
                ),
                _SidebarButton(
                  icon: LucideIcons.settings,
                  title: 'Настройки',
                  isCollapsed: isCollapsed,
                  onTap: onSettingsTap,
                ),
                if (!isCollapsed)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.dividerColor.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: theme.colorScheme.primary,
                          child: const Text(
                            'AD',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Admin User',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'admin@panel.com',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          LucideIcons.logOut,
                          size: 16,
                          color: theme.iconTheme.color?.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isCollapsed;
  final VoidCallback onTap;

  const _SidebarButton({
    required this.icon,
    required this.title,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isCollapsed ? 12 : 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: theme.iconTheme.color?.withOpacity(0.6),
              ),
              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                Text(
                  title,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const _TopBar({this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          if (onMenuTap != null)
            IconButton(
              icon: const Icon(LucideIcons.menu),
              onPressed: onMenuTap,
            ),
          const Spacer(),
          const SizedBox(width: 16),
          // нотификации
          Stack(
            children: [
              IconButton(
                icon: const Icon(LucideIcons.bell),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SidebarItem {
  final String title;
  final IconData icon;
  final PageRouteInfo route;
  final String? badge;
  final Color? badgeColor;

  SidebarItem({
    required this.title,
    required this.icon,
    required this.route,
    this.badge,
    this.badgeColor,
  });
} 