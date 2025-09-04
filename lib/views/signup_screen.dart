import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lost_found_app/auth/service/auth_provider.dart';
import 'package:lost_found_app/auth/service/auth_service.dart';
import 'package:lost_found_app/go_route.dart';
import 'package:lost_found_app/theme/color.dart';
import 'package:lost_found_app/utils/my_button.dart';
import 'package:lost_found_app/utils/snackbar.dart';
import 'package:lost_found_app/views/login_screen.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(authFormProvider);
    final formNotifier = ref.watch(authFormProvider.notifier);
    final authMethod = ref.read(authMethodProvider);

    Future<void> sigup() async {
      formNotifier.setLoading(true);
      final res = await authMethod.signUp(
        email: formState.email,
        password: formState.password,
        name: formState.name,
      );
      formNotifier.setLoading(false);
      if (!context.mounted) return;
      if (res == "success") {
        NavigationHelper.pushReplacement(context, const LoginScreen());
        mySnackBar(
          message: "Account created successfully",
          context: context,
        );
      } else {
        mySnackBar(
          message: res,
          context: context,
        );
      }
    }

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: height / 2.4,
              width: double.maxFinite,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: shadowColor, blurRadius: 15, spreadRadius: 20),
                ],
              ), // BoxDecoration
              child: SvgPicture.asset("assets/images/signup.svg",
                  fit: BoxFit.cover),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    autocorrect: false,
                    onChanged: (value) => formNotifier.updateName(value),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: "Enter Your Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                      errorText: formState.nameError,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    autocorrect: false,
                    onChanged: (value) => formNotifier.updateEmail(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      labelText: "Enter Your Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                      errorText: formState.emailError,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    autocorrect: false,
                    onChanged: (value) => formNotifier.updatePassword(value),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: formState.isPasswordHidden,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Enter Your Password",
                      border: const OutlineInputBorder(),
                      errorText: formState.passwordError,
                      suffixIcon: IconButton(
                        onPressed: () =>
                            formNotifier.togglePasswordVisibility(),
                        icon: Icon(formState.isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  formState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : MyButton(
                          onTab: formState.isFormValid ? sigup : null,
                          buttonText: "Signup",
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text("Already have an account?"),
                      GestureDetector(
                        onTap: () {
                          NavigationHelper.pushReplacement(
                              context, const LoginScreen());
                        },
                        child: const Text(
                          " Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
