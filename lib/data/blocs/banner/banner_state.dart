import 'package:equatable/equatable.dart';

import '../../models/banner/banner_model.dart';
import '../../models/forms_status.dart';

class BannerState extends Equatable {
  final List<BannerModel> banners;
  final FormsStatus status;
  final String errorMessage;

  const BannerState({
    required this.banners,
    required this.status,
    required this.errorMessage,
  });

  BannerState copyWith({
    List<BannerModel>? banners,
    FormsStatus? status,
    String? errorMessage,
  }) {
    return BannerState(
      banners: banners ?? this.banners,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  static BannerState initialValue() => BannerState(
      banners: BannerModel.initialValue(),
      status: FormsStatus.pure,
      errorMessage: '');

  @override
  List<Object?> get props => [
    banners,
    status,
    errorMessage,
  ];
}
