import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    return Scaffold(
      body: SafeArea(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.authorizationUrl.toString(),
        ),
      ),
    );
  }
}
