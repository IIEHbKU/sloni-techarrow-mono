import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/screens/auth_legacy/features/buttons.dart';

class LoginAuthScreenWidget extends StatefulWidget {
  const LoginAuthScreenWidget(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.passwordFocusNode});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;

  @override
  State<LoginAuthScreenWidget> createState() => _LoginAuthScreenWidgetState();
}

class _LoginAuthScreenWidgetState extends State<LoginAuthScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Email or username'),
            onSubmitted: (value) {
              widget.passwordFocusNode.requestFocus();
            },
            controller: widget.emailController,
            autofocus: true,
            autocorrect: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Password'),
            controller: widget.passwordController,
            focusNode: widget.passwordFocusNode,
            autocorrect: false,
            onSubmitted: (value) {
              {
                AuthScreenButtonActions.login(widget.emailController.text,
                    widget.passwordController.text, context);
              }
            },
          ),
        ),
      ],
    );
  }
}
