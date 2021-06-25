import 'package:flutter/material.dart';

class AuthorizationPage extends StatefulWidget {
  final Uri authorizationUri;
  final void Function(Uri redirectUri) onAuthorizationCodeRedirectAttempt;
  const AuthorizationPage({
    Key? key,
    required this.authorizationUri,
    required this.onAuthorizationCodeRedirectAttempt,
  }) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
