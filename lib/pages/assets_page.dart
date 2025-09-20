import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  @override
  void initState() {
    SimpleLogger.d('32', 'AssetsPage initState called');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('33', 'AssetsPage build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('资产'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 64, color: Colors.teal),
            SizedBox(height: 16),
            Text(
              '资产',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '我的资产',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
