import 'package:fin_smart/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fin_smart/core/theme/dark_theme.dart';
import 'package:fin_smart/core/theme/light_theme.dart';
import 'package:fin_smart/core/utils/enums.dart'; 
import 'package:fin_smart/features/authentication/presentation/pages/splash_screen.dart';
import 'package:fin_smart/l10n/app_localizations.dart';
import 'package:fin_smart/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FinTecApp extends StatefulWidget {
  const FinTecApp({super.key, required this.local, required this.themeMode});

  final Locale local;
  final ThemeModes themeMode;

  @override
  State<FinTecApp> createState() => _FinTecAppState();
}

class _FinTecAppState extends State<FinTecApp> {
  @override
  void initState() {
    super.initState();
    context.read<AppUserCubit>().checkLoginSession();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinTec',
      theme: widget.themeMode == ThemeModes.light ? lightTheme : darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: widget.local,
      debugShowCheckedModeBanner: false,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          return SplashPage();
        },
      ),
    );
  }
}
