import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/presentation/pages/home/widgets/header_card.dart';
import 'package:hihear_mo/presentation/pages/home/widgets/lesson_path.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with TickerProviderStateMixin {
  late final AnimationController _headerController;
  late final AnimationController _slideController;
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        final lessons = state.maybeWhen(data: (data) => data, orElse: () => <LessionEntity>[],);

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _slideController,
                  curve: Curves.easeOutCubic,
                )),
                child: FadeTransition(
                  opacity: _fadeController,
                  child: Column(
                    children: [
                      const SizedBox(height: AppPadding.large),
                      HeaderCard(controller: _headerController),
                      const SizedBox(height: AppPadding.xxLarge),
                    ],
                  ),
                ),
              ),
            ),
            
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
              sliver: LessonPath(lessons: lessons),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        );
      },
    );
  }
}