import 'package:flutter/material.dart';

class AuthorizatioPage extends StatefulWidget {
  final Uri authorizationUrl;
  final void Function(Uri redirectUri) onAuthorizationCodeRedirectAttempt;
  const AuthorizatioPage({
    Key? key,
    required this.authorizationUrl,
    required this.onAuthorizationCodeRedirectAttempt,
  }) : super(key: key);

  @override
  _AuthorizatioPageState createState() => _AuthorizatioPageState();
}

class _AuthorizatioPageState extends State<AuthorizatioPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
