// profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/data/datasources/auth_remote_data_source.dart';
import 'package:hihear_mo/data/repositories/auth_repository_impl.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/auth/auth_bloc.dart';
import 'package:hihear_mo/presentation/routes/app_routes.dart';
import 'package:hihear_mo/presentation/widgets/profile_info_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryImpl(AuthRemoteDataSource());

    // BlocProvider tách ra ngoài để context con truy cập Bloc an toàn
    return BlocProvider(
      create: (_) => AuthBloc(authRepository),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          loggedOut: () {
            context.go(AppRoutes.login);
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(size),
                  const SizedBox(height: 70),
                  _buildProfileInfo(context),
                  const SizedBox(height: 28),
                  _buildStats(context, l10n),
                  const SizedBox(height: 30),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Size size) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: size.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.hearuHi),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 55,
              backgroundColor: AppColors.gold,
              child: const CircleAvatar(
                radius: 52,
                backgroundImage: AssetImage(AppAssets.hearuAvatar),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          "Hoàng",
          style: AppTextStyles.title.copyWith(
            fontSize: 24,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "hcassano.dev@gmail.com",
          style: AppTextStyles.subtitle.copyWith(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ProfileInfoCard(
            icon: Icons.local_fire_department,
            title: l10n.seriesOfDays,
            value: "7 ${l10n.dayLabel}",
            color: Colors.orangeAccent,
          ),
          const SizedBox(height: 12),
          ProfileInfoCard(
            icon: Icons.star,
            title: l10n.level,
            value: "Cấp 1",
            color: AppColors.gold,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_buildEditButton(context), _buildLogoutButton(context)],
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // context.go('/editProfile');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(12),
        minimumSize: const Size(50, 50),
      ),
      child: const Icon(Icons.edit, color: Colors.white, size: 20),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AuthBloc>().add(const AuthEvent.logout());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(12),
        minimumSize: const Size(50, 50),
      ),
      child: const Icon(Icons.logout, color: Colors.white, size: 20),
    );
  }
}
