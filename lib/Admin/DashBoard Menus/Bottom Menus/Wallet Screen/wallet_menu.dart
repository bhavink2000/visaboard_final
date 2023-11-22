import 'package:flutter/material.dart';

class WalletMenuPage extends StatefulWidget {
  const WalletMenuPage({Key? key}) : super(key: key);

  @override
  State<WalletMenuPage> createState() => _WalletMenuPageState();
}

class _WalletMenuPageState extends State<WalletMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Wallet"));
  }
}
