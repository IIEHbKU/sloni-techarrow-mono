import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/screens/auth_legacy/features/buttons.dart';

class RegisterAuthScreenWidget extends StatefulWidget {
  const RegisterAuthScreenWidget(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.passwordFocusNode,
      required this.nicknameController,
      required this.nicknameFocusNode});

  final TextEditingController emailController;
  final TextEditingController nicknameController;
  final FocusNode nicknameFocusNode;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;

  @override
  State<RegisterAuthScreenWidget> createState() =>
      _RegisterAuthScreenWidgetState();
}

class _RegisterAuthScreenWidgetState extends State<RegisterAuthScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Email'),
            onSubmitted: (value) {
              widget.nicknameFocusNode.requestFocus();
            },
            controller: widget.emailController,
            autofocus: true,
            autocorrect: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Username'),
            onSubmitted: (value) {
              widget.passwordFocusNode.requestFocus();
            },
            controller: widget.nicknameController,
            focusNode: widget.nicknameFocusNode,
            autofocus: true,
            autocorrect: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Password'),
              controller: widget.passwordController,
              focusNode: widget.passwordFocusNode,
              autocorrect: false,
              onSubmitted: (value) {
                AuthScreenButtonActions.register(
                    widget.nicknameController.text,
                    widget.emailController.text,
                    widget.passwordController.text,
                    context);
              }),
        ),
      ],
    );
  }
}
