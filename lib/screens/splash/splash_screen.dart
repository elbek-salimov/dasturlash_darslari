import 'package:dasturlash_darslari/data/models/forms_status.dart';
import 'package:dasturlash_darslari/utils/images/app_images.dart';
import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:dasturlash_darslari/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/blocs/auth/auth_bloc.dart';
import '../../utils/colors/app_colors.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init(bool authorized) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    if (authorized) {
      Navigator.pushReplacementNamed(context, RouteNames.sideBar);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.start);
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.cD4E0E8,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == FormsStatus.authenticated) {
            _init(true);
          } else {
            _init(false);
          }
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.appLogo, height: 90.h),
              10.getW(),
              Text(
                ('Dasturlash \nDarslari'),
                style: AppTextStyle.sfProRoundedBold
                    .copyWith(fontSize: 36.h, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
