import 'package:equatable/equatable.dart';
import 'package:fin_smart/core/local_data/secure_local_data_helper.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final LocalDataHelper localData;

  AppUserCubit(this.localData) : super(AppUserInitial());

  Future<void> checkLoginSession() async {
    if (await localData.getLoginFlag()) {
      emit(const AppUserLoggedIn());
    } else {
      emit(AppUserInitial());
    }
  }

  Future<String> loadToken() async {
    return await localData.getToken();
  }
}
