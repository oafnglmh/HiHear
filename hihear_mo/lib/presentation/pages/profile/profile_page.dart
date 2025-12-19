import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/auth/auth_bloc.dart';
import 'package:hihear_mo/data/repositories/auth_repository_impl.dart';
import 'package:hihear_mo/data/datasources/auth_remote_data_source.dart';
import 'package:hihear_mo/share/UserShare.dart';
    
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryImpl(AuthRemoteDataSource());

    return BlocProvider(
      create: (_) => AuthBloc(authRepository),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.loadUser());
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
    Widget? trailing,
  }) {
    final itemColor = color ?? const Color(0xFF1B7F4E);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: itemColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: itemColor, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
        trailing: trailing ??
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey[400],
            size: 24,
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          loggedOut: () => context.go('/login'),
          error: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
      builder: (context, state) {
        final user = state.maybeWhen(
          authenticated: (user) => user, 
          orElse: () => null,
        );

        if (user == null) {
          return const Scaffold(
            backgroundColor: Color(0xFF1B7F4E),
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1B7F4E),
                        Color(0xFF0D6B3D),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B7F4E).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 38,
                          backgroundImage: NetworkImage(
                            user.photoUrl ?? AppAssets.hearuAvatar,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name?.trim().isNotEmpty == true 
                                  ? user.name! 
                                  : "Người dùng",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              user.email?.trim().isNotEmpty == true 
                                  ? user.email! 
                                  : "No email",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.85),
                                letterSpacing: 0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => context.read<AuthBloc>().add(
                            const AuthEvent.logout(),
                          ),
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          tooltip: 'Đăng xuất',
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Chuỗi ngày",
                          UserShare().dailyStreak ?? "0",
                          Icons.local_fire_department_rounded,
                          const Color(0xFFFF6B35),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          "Bài học",
                          "24",
                          Icons.school_rounded,
                          const Color(0xFF1B7F4E),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          "Điểm số",
                          "1.2K",
                          Icons.star_rounded,
                          const Color(0xFFFFC107),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 12),
                        child: Text(
                          "Cài đặt & Tùy chọn",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      
                      _buildMenuItem(
                        title: "Chỉnh sửa hồ sơ",
                        icon: Icons.person_rounded,
                        onTap: () {},
                        color: const Color(0xFF1B7F4E),
                      ),
                      _buildMenuItem(
                        title: "Thông báo",
                        icon: Icons.notifications_rounded,
                        onTap: () {},
                        color: const Color(0xFFFF6B35),
                        trailing: Switch(
                          value: true,
                          onChanged: (val) {},
                          activeColor: const Color(0xFF1B7F4E),
                        ),
                      ),
                      _buildMenuItem(
                        title: "Ngôn ngữ",
                        icon: Icons.language_rounded,
                        onTap: () => context.go('/language'),
                        color: const Color(0xFF4A90E2),
                      ),
                      _buildMenuItem(
                        title: "Quyền riêng tư & Bảo mật",
                        icon: Icons.shield_rounded,
                        onTap: () {},
                        color: const Color(0xFF9B59B6),
                      ),
                      _buildMenuItem(
                        title: "Trợ giúp & Hỗ trợ",
                        icon: Icons.help_rounded,
                        onTap: () => context.go('/help'),
                        color: const Color(0xFFE74C3C),
                      ),
                      _buildMenuItem(
                        title: "Về ứng dụng",
                        icon: Icons.info_rounded,
                        onTap: () => context.go('/about'),
                        color: const Color(0xFF16A085),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}