import 'package:fin_smart/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fin_smart/core/local_data/secure_local_data_helper.dart';
import 'package:fin_smart/core/utils/enums.dart';
import 'package:fin_smart/core/utils/extensions/extensions.dart';
import 'package:fin_smart/features/authentication/presentation/pages/login_screen.dart';
import 'package:fin_smart/inti.dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (context.read<AppUserCubit>().state.accessToken != null &&
          context.read<AppUserCubit>().state.accessToken!.isNotEmpty &&
          context.read<AppUserCubit>().state.status ==
              AppUserStatus.authenticated) {
        // TODO: Navigate to Home Page
      } else {
        if (mounted) context.pushAndRemoveUntil(LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FlutterLogo(size: 80),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
