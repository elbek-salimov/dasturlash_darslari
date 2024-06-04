import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/blocs/auth/auth_bloc.dart';
import '../../data/models/forms_status.dart';
import '../routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("settings", style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
            child: Column(
              children: [
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status == FormsStatus.unauthenticated) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteNames.start, (route) => false);
                    }
                  },
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      context.read<AuthBloc>().add(LogOutUserEvent());
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 13.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.logout,
                              color: Theme.of(context).iconTheme.color),
                          SizedBox(width: 13.w),
                          Text('log_out',
                              style: Theme.of(context).textTheme.bodyMedium)
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'version 1.0',
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
