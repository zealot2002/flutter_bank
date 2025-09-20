import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class FuturesPage extends StatefulWidget {
  const FuturesPage({super.key});

  @override
  State<FuturesPage> createState() => _FuturesPageState();
}

class _FuturesPageState extends State<FuturesPage> {
  @override
  void initState() {
    SimpleLogger.d('30', 'FuturesPage initState called');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('31', 'FuturesPage build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('合约'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance, size: 64, color: Colors.purple),
            SizedBox(height: 16),
            Text(
              '合约',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '期货合约交易',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
