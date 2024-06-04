import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/forms_status.dart';
import '../../models/network_response.dart';
import '../../repository/banner/banner_repository.dart';
import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required this.bannerRepository})
      : super(BannerState.initialValue()) {
    on<GetBannerEvent>(_getBanner);
  }

  final BannerRepository bannerRepository;

  _getBanner(GetBannerEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse = await bannerRepository.getBanner();
    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
        status: FormsStatus.success,
        banners: networkResponse.data,
      ));
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }
}
