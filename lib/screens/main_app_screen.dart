import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../utils/theme.dart';
import 'dashboard_screen.dart';
import 'reptiles_screen.dart';
import 'breeding_screen.dart';
import 'schedule_screen.dart';
import 'inventory_screen.dart';
import 'reports_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;
  bool _isMobileMenuOpen = false;

  final List<Widget> _screens = const [
    DashboardScreen(),
    ReptilesScreen(),
    BreedingScreen(),
    ScheduleScreen(),
    InventoryScreen(),
    ReportsScreen(),
  ];

  final List<NavigationItem> _navigationItems = const [
    NavigationItem(
      icon: Icons.home,
      label: 'Dashboard',
      section: 'dashboard',
    ),
    NavigationItem(
      icon: Icons.drag_indicator,
      label: 'Reptiles',
      section: 'animals',
    ),
    NavigationItem(
      icon: Icons.science,
      label: 'Breeding',
      section: 'breeding',
    ),
    NavigationItem(
      icon: Icons.calendar_today,
      label: 'Schedule',
      section: 'schedule',
    ),
    NavigationItem(
      icon: Icons.inventory,
      label: 'Inventory',
      section: 'inventory',
    ),
    NavigationItem(
      icon: Icons.analytics,
      label: 'Reports',
      section: 'reports',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb 
        ? _buildWebLayout()
        : _buildMobileLayout(),
    );
  }

  Widget _buildWebLayout() {
    return Column(
      children: [
        // Top Navigation Bar (matching HTML exactly)
        _buildTopNavigationBar(),
        // Mobile Navigation Menu (overlay)
        if (_isMobileMenuOpen) _buildMobileNavigationMenu(),
        // Main Content Area
        Expanded(
          child: _screens[_currentIndex],
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SafeArea(
      bottom: false, // Let individual screens handle bottom safe area
      child: Column(
        children: [
          // Top Navigation Bar (matching HTML exactly)
          _buildTopNavigationBar(),
          // Mobile Navigation Menu (overlay)
          if (_isMobileMenuOpen) _buildMobileNavigationMenu(),
          // Main Content Area
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavigationBar() {
    final authService = context.watch<AuthService>();
    final themeService = context.watch<ThemeService>();
    final userData = authService.userData;
    final isMobile = MediaQuery.of(context).size.width <= 768;
    
    // Debug: Print screen width and mobile status
    if (kDebugMode) {
      print('Screen width: ${MediaQuery.of(context).size.width}');
      print('Is mobile: $isMobile');
    }

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppTheme.bgPrimary,
        boxShadow: AppTheme.shadowSm,
      ),
      child: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1400),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // Brand Section
              _buildBrandSection(),
              
              // Navigation Menu (hidden on mobile)
              if (!isMobile) 
                Expanded(
                  child: _buildNavigationMenu(),
                ),
              
              // Spacer to push user section and menu toggle to the right
              if (isMobile) const Spacer(),
              
              // User Section
              _buildUserSection(userData, themeService, authService),
              
              // Mobile Menu Toggle (only on mobile)
              if (isMobile) _buildMobileMenuToggle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandSection() {
    return Row(
      children: [
        Icon(
          Icons.drag_indicator,
          size: 32,
          color: AppTheme.primaryColor,
        ),
        const SizedBox(width: 10),
        Text(
          'RepFiles',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _navigationItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isActive = _currentIndex == index;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
            },
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                color: isActive ? AppTheme.bgSecondary : Colors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: 20,
                    color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMobileMenuToggle() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isMobileMenuOpen = !_isMobileMenuOpen;
        });
      },
      icon: Icon(
        _isMobileMenuOpen ? Icons.close : Icons.menu,
        color: AppTheme.textSecondary,
        size: 24,
      ),
    );
  }

  Widget _buildMobileNavigationMenu() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.bgPrimary,
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        children: _navigationItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isActive = _currentIndex == index;

          return InkWell(
            onTap: () {
              setState(() {
                _currentIndex = index;
                _isMobileMenuOpen = false;
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: isActive ? AppTheme.bgSecondary : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.borderColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    size: 20,
                    color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUserSection(
    Map<String, dynamic>? userData,
    ThemeService themeService,
    AuthService authService,
  ) {
    final isMobile = MediaQuery.of(context).size.width <= 768;
    
    // Debug: Print user data to console
    if (kDebugMode) {
      print('User data: $userData');
      print('Current user: ${authService.currentUser?.email}');
    }

    return Row(
      children: [
        // User Info Section (matching HTML structure) - show on all screen sizes
        // if (!isMobile) ...[
        ...[
          // Pro Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.accentColor,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
            ),
            child: Text(
              'Pro',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // User Name
          Text(
            userData?['name'] ?? authService.currentUser?.displayName ?? authService.currentUser?.email?.split('@')[0] ?? 'Guest',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(width: 15),
        ],
        
        // User Menu with hover effect
        _UserMenuButton(
          userData: userData,
          themeService: themeService,
          authService: authService,
        ),
      ],
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String section;

  const NavigationItem({
    required this.icon,
    required this.label,
    required this.section,
  });
}

// Keep the MainAppBar for individual screens that need it
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showUserMenu;

  const MainAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showUserMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        if (actions != null) ...actions!,
        if (showUserMenu) _buildUserMenu(context),
      ],
    );
  }

  Widget _buildUserMenu(BuildContext context) {
    final authService = context.watch<AuthService>();
    final themeService = context.watch<ThemeService>();
    final userData = authService.userData;

    return PopupMenuButton<String>(
      icon: CircleAvatar(
        backgroundColor: AppTheme.primaryColor,
        child: Text(
          userData?['name']?.substring(0, 1).toUpperCase() ?? 'U',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userData?['name'] ?? 'User',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                userData?['email'] ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person),
              SizedBox(width: 8),
              Text('Profile'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 8),
              Text('Settings'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'help',
          child: Row(
            children: [
              Icon(Icons.help),
              SizedBox(width: 8),
              Text('Help'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'theme',
          child: Row(
            children: [
              Icon(themeService.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              const SizedBox(width: 8),
              Text(themeService.isDarkMode ? 'Switch to Light' : 'Switch to Dark'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout),
              SizedBox(width: 8),
              Text('Sign Out'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'theme':
            themeService.toggleTheme();
            break;
          case 'logout':
            authService.signOut();
            break;
          case 'profile':
          case 'settings':
          case 'help':
            // TODO: Implement these features
            break;
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UserMenuButton extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final ThemeService themeService;
  final AuthService authService;

  const _UserMenuButton({
    required this.userData,
    required this.themeService,
    required this.authService,
  });

  @override
  State<_UserMenuButton> createState() => _UserMenuButtonState();
}

class _UserMenuButtonState extends State<_UserMenuButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: PopupMenuButton<String>(
        offset: const Offset(0, 36), // Move menu down by 16 pixels (increased from 8)
        icon: Icon(
          Icons.account_circle,
          size: 24,
          color: _isHovered ? const Color(0xFF00FF00) : AppTheme.textSecondary,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            enabled: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userData?['name'] ?? 'User',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  widget.userData?['email'] ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'profile',
            child: Row(
              children: [
                Icon(Icons.person, size: 16),
                SizedBox(width: 8),
                Text('Profile'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'settings',
            child: Row(
              children: [
                Icon(Icons.settings, size: 16),
                SizedBox(width: 8),
                Text('Settings'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'help',
            child: Row(
              children: [
                Icon(Icons.help, size: 16),
                SizedBox(width: 8),
                Text('Help'),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'theme',
            child: Row(
              children: [
                Icon(
                  widget.themeService.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(widget.themeService.isDarkMode ? 'Switch to Light' : 'Switch to Dark'),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout, size: 16),
                SizedBox(width: 8),
                Text('Sign Out'),
              ],
            ),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case 'theme':
              widget.themeService.toggleTheme();
              break;
            case 'logout':
              widget.authService.signOut();
              break;
            case 'profile':
            case 'settings':
            case 'help':
              // TODO: Implement these features
              break;
          }
        },
      ),
    );
  }
} 