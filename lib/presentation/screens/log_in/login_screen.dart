import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:real_social_app/presentation/screens/log_in/widgets/google_sign_in_widget.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GoogleSignInWidget());
  }
}
