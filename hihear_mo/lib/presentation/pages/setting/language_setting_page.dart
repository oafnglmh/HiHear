import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/core/enums/language_type.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/presentation/blocs/language/language_bloc.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

class LanguageSettingPage extends StatelessWidget {
  const LanguageSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final currentLocale = context.watch<LanguageBloc>().state.locale;

    final languages = {
      LanguageType.vietnamese: loc.languageVietnamese,
      LanguageType.english: loc.languageEnglish,
    };

    return Scaffold(
      backgroundColor: AppColors.bgWhiteCustom,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          loc.languageSelectTitle,
          style: const TextStyle(
            color: AppColors.textWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: ListView(
          children: LanguageType.values.map((lang) {
            final isSelected = currentLocale.languageCode == lang.code;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.background.withOpacity(0.9)
                    : AppColors.cardBg,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: AppColors.background.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 18,
                  backgroundColor: isSelected
                      ? AppColors.textWhite.withOpacity(0.2)
                      : AppColors.background.withOpacity(0.1),
                  child: Icon(
                    lang == LanguageType.english
                        ? Icons.language
                        : Icons.flag_rounded,
                    color: isSelected
                        ? AppColors.textWhite
                        : AppColors.background,
                    size: 20,
                  ),
                ),
                title: Text(
                  languages[lang]!,
                  style: AppTextStyles.title.copyWith(
                    color: isSelected
                        ? AppColors.textWhite
                        : AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                trailing: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: isSelected
                      ? const Icon(
                          Icons.check_circle_rounded,
                          key: ValueKey(true),
                          color: Colors.white,
                        )
                      : const SizedBox(key: ValueKey(false)),
                ),
                onTap: () {
                  context.read<LanguageBloc>().add(ChangeLanguageEvent(lang));
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
