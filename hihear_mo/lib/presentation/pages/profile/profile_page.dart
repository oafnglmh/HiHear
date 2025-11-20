import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/domain/entities/user/user_entity.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/auth/auth_bloc.dart';
import 'package:hihear_mo/presentation/routes/app_routes.dart';
import 'package:hihear_mo/presentation/widgets/ShimmerWidget.dart';
import 'package:hihear_mo/data/repositories/auth_repository_impl.dart';
import 'package:hihear_mo/data/datasources/auth_remote_data_source.dart';

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

class _ProfileViewState extends State<_ProfileView> with TickerProviderStateMixin {
  late AnimationController _bambooController;
  late AnimationController _headerController;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.loadUser());
    
    _bambooController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _bambooController.dispose();
    _headerController.dispose();
    super.dispose();
  }

  Widget _buildStatCard(String title, String value, String emoji, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
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
              color: const Color(0xFF2D5016).withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required String emoji,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                (iconColor ?? const Color(0xFFD4AF37)).withOpacity(0.2),
                (iconColor ?? const Color(0xFFD4AF37)).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(emoji, style: const TextStyle(fontSize: 24)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D5016),
          ),
        ),
        trailing: trailing ?? 
          const Icon(
            Icons.arrow_forward_ios_rounded, 
            size: 16, 
            color: Color(0xFFD4AF37),
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
              backgroundColor: const Color(0xFFDA291C),
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
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF4A7C2C),
                        Color(0xFF5E9A3A),
                        Color(0xFF3D6624),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFD4AF37),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4A7C2C),
                      Color(0xFF5E9A3A),
                      Color(0xFF3D6624),
                    ],
                  ),
                ),
              ),

              AnimatedBuilder(
                animation: _bambooController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: BambooPainter(
                      animationValue: _bambooController.value,
                    ),
                    size: Size.infinite,
                  );
                },
              ),

              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250,
                    pinned: true,
                    backgroundColor: const Color(0xFF4A7C2C),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF4A7C2C).withOpacity(0.8),
                              const Color(0xFF5E9A3A).withOpacity(0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFD4AF37),
                                      width: 4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFD4AF37).withOpacity(0.4),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      user.photoUrl ?? AppAssets.hearuAvatar,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Name
                                Text(
                                  user.name?.trim().isNotEmpty == true 
                                      ? user.name! 
                                      : "Người dùng",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Email
                                Text(
                                  user.email?.trim().isNotEmpty == true 
                                      ? user.email! 
                                      : "No email",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => context.read<AuthBloc>().add(
                            const AuthEvent.logout(),
                          ),
                          icon: const Icon(Icons.logout_rounded, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  
                  SliverToBoxAdapter(
                    child: FadeTransition(
                      opacity: _headerController,
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          
                          // Stats Cards
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildStatCard(
                                    "Chuỗi ngày",
                                    "7",
                                    "🔥",
                                    const Color(0xFFDA291C),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildStatCard(
                                    "Bài học",
                                    "24",
                                    "📚",
                                    const Color(0xFF4A7C2C),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildStatCard(
                                    "Điểm số",
                                    "1.2K",
                                    "⭐",
                                    const Color(0xFFD4AF37),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Achievement Card
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD4AF37),
                                    Color(0xFFB8941E),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFD4AF37).withOpacity(0.4),
                                    blurRadius: 16,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text(
                                      '🏆',
                                      style: TextStyle(fontSize: 36),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Học viên xuất sắc",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Tiếp tục phát huy nhé! 🎉",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Menu Section
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFD4AF37),
                                        Color(0xFFB8941E),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    "⚙️ Cài đặt",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                
                                _buildMenuTile(
                                  emoji: "👤",
                                  title: "Chỉnh sửa hồ sơ",
                                  onTap: () {},
                                  iconColor: const Color(0xFF4A7C2C),
                                ),
                                _buildMenuTile(
                                  emoji: "🔔",
                                  title: "Thông báo",
                                  onTap: () {},
                                  iconColor: const Color(0xFFDA291C),
                                  trailing: Switch(
                                    value: true,
                                    onChanged: (val) {},
                                    activeColor: const Color(0xFFD4AF37),
                                  ),
                                ),
                                _buildMenuTile(
                                  emoji: "🌍",
                                  title: "Ngôn ngữ",
                                  onTap: () {
                                    context.go('/language');
                                  },
                                  iconColor: const Color(0xFF667eea),
                                ),
                                _buildMenuTile(
                                  emoji: "🔒",
                                  title: "Quyền riêng tư & Bảo mật",
                                  onTap: () {},
                                  iconColor: const Color(0xFF764ba2),
                                ),
                                _buildMenuTile(
                                  emoji: "❓",
                                  title: "Trợ giúp & Hỗ trợ",
                                  onTap: () {
                                    context.go('/help');
                                  },
                                  iconColor: const Color(0xFFFF8C50),
                                ),
                                _buildMenuTile(
                                  emoji: "ℹ️",
                                  title: "Về ứng dụng",
                                  onTap: () {
                                    context.go('/about');
                                  },
                                  iconColor: const Color(0xFF43e97b),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// Bamboo Painter
class BambooPainter extends CustomPainter {
  final double animationValue;

  BambooPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D5016).withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    _drawBamboo(canvas, size, 30, paint, animationValue);
    _drawBamboo(canvas, size, size.width - 30, paint, -animationValue);
  }

  void _drawBamboo(Canvas canvas, Size size, double x, Paint paint, double sway) {
    final path = Path();
    final segments = 6;
    final segmentHeight = size.height / segments;
    
    for (int i = 0; i < segments; i++) {
      final y = i * segmentHeight;
      final swayOffset = sway * 10 * (i / segments);
      
      path.moveTo(x + swayOffset, y);
      path.lineTo(x + swayOffset, y + segmentHeight - 10);
      
      canvas.drawCircle(
        Offset(x + swayOffset, y + segmentHeight - 10),
        5,
        paint,
      );
      
      if (i > 2) {
        final leafPaint = Paint()
          ..color = const Color(0xFF6DB33F).withOpacity(0.15)
          ..style = PaintingStyle.fill;
        
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x + swayOffset + 15, y + segmentHeight / 2),
            width: 30,
            height: 10,
          ),
          leafPaint,
        );
        
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x + swayOffset - 15, y + segmentHeight / 2 + 5),
            width: 30,
            height: 10,
          ),
          leafPaint,
        );
      }
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BambooPainter oldDelegate) => true;
}