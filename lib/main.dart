import 'package:fin_smart/application.dart';
import 'package:fin_smart/core/common/cubits/locale_cubit/language_state.dart';
import 'package:fin_smart/core/common/cubits/theme/theme_state.dart';
import '/core/common/cubits/locale_cubit/language_cubit.dart';
import 'core/common/cubits/app_user/user_session_cubit.dart';
import '/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/common/cubits/theme/theme_cubit.dart';
import 'inti.dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserSessionCubit>(
          create: (_) => serviceLocator<UserSessionCubit>(),
        ),
        BlocProvider<AuthCubit>(create: (_) => serviceLocator<AuthCubit>()),
        BlocProvider<LanguageCubit>(
          create: (_) => serviceLocator<LanguageCubit>(),
        ),
        BlocProvider<ThemeCubit>(create: (_) => serviceLocator<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, localeState) {
              return FinTecApp(
                local: localeState.locale,
                themeMode: themeState.theme,
              );
            },
          );
        },
      ),
    ),
  );
}
