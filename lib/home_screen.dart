import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_found_app/auth/service/auth_service.dart';
import 'package:lost_found_app/go_route.dart';
import 'package:lost_found_app/utils/background_gradient.dart';
import 'package:lost_found_app/utils/snackbar.dart';
import 'package:lost_found_app/views/login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authMethod = ref.read(authMethodProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 3,
        title: const Center(
          child: Text('Lost & Found App'),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: BackgroundGradient(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              await authMethod.logOut();
              if (context.mounted) {
                mySnackBar(
                  message: "Successfully logged out",
                  context: context,
                );
                NavigationHelper.pushReplacement(context, const LoginScreen());
              }
            },
            child: const Text('Logout'),
          ),
        ),
      ),
    );
  }
}
