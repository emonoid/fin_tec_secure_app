import 'package:fin_smart/core/common/cubits/app_user/app_user_state.dart';
import 'package:fin_smart/core/local_data/secure_local_data_helper.dart';
import 'package:fin_smart/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final LocalDataHelper localData;

  AppUserCubit(this.localData)
    : super(AppUserState(status: AppUserStatus.unknown));

  void setAppUserStatus(AppUserStatus status, {String? accessToken}) {
    emit(state.copyWith(status: status, accessToken: accessToken));
  }
}
