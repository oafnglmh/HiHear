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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          loc.languageSelectTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: LanguageType.values.map((lang) {
          final isSelected = currentLocale.languageCode == lang.code;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.background
                  : AppColors.gold.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                lang == LanguageType.english ? Icons.language : Icons.flag,
                color: isSelected ? AppColors.gold : AppColors.textWhite,
              ),
              title: Text(
                languages[lang]!,
                style: AppTextStyles.title.copyWith(
                  color: isSelected ? AppColors.textWhite : AppColors.gold,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.greenAccent)
                  : const SizedBox(),
              onTap: () {
                context.read<LanguageBloc>().add(ChangeLanguageEvent(lang));
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
