import 'package:fin_smart/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountHomeScreen extends StatefulWidget {
  const AccountHomeScreen({super.key});

  @override
  State<AccountHomeScreen> createState() => _AccountHomeScreenState();
}

class _AccountHomeScreenState extends State<AccountHomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("access token: ${context.read<AppUserCubit>().state.accessToken}");
    return const Placeholder();
  }
}
