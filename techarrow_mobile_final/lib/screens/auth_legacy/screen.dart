import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/screens/auth_legacy/features/buttons.dart';
import 'package:techarrow_mobile_final/screens/auth_legacy/ui/login.dart';

import 'ui/register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum AuthScreenStates { login, register }

// unused
class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _nicknameFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  AuthScreenStates state = AuthScreenStates.login;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _nicknameController.dispose();
    _nicknameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Spacer(),
            state == AuthScreenStates.login
                ? LoginAuthScreenWidget(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    passwordFocusNode: _passwordFocusNode)
                : RegisterAuthScreenWidget(
                    emailController: _emailController,
                    nicknameController: _nicknameController,
                    nicknameFocusNode: _nicknameFocusNode,
                    passwordController: _passwordController,
                    passwordFocusNode: _passwordFocusNode,
                  ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: state == AuthScreenStates.login
                      ? ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).primaryColor),
                        )
                      : null,
                  onPressed: state == AuthScreenStates.login
                      ? () {
                          AuthScreenButtonActions.login(_emailController.text,
                              _passwordController.text, context);
                        }
                      : () {
                          setState(() {
                            state = AuthScreenStates.login;
                          });
                        },
                  child: Text(
                    'Log in',
                    style: state == AuthScreenStates.login
                        ? const TextStyle(fontSize: 20, color: Colors.white)
                        : const TextStyle(fontSize: 20),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "or",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  style: state == AuthScreenStates.register
                      ? ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).primaryColor),
                        )
                      : null,
                  onPressed: state == AuthScreenStates.register
                      ? () {
                          AuthScreenButtonActions.register(
                              _nicknameController.text,
                              _emailController.text,
                              _passwordController.text,
                              context);
                        }
                      : () {
                          setState(() {
                            state = AuthScreenStates.register;
                          });
                        },
                  child: Text(
                    'Sign up',
                    style: state == AuthScreenStates.register
                        ? const TextStyle(fontSize: 20, color: Colors.white)
                        : const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
