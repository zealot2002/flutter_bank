import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class CopyTradePage extends StatefulWidget {
  const CopyTradePage({super.key});

  @override
  State<CopyTradePage> createState() => _CopyTradePageState();
}

class _CopyTradePageState extends State<CopyTradePage> {
  @override
  void initState() {
    super.initState();
    SimpleLogger.d('43', 'CopyTradePage initState called');
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('44', 'CopyTradePage build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('跟单'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.copy, size: 64, color: Colors.purple),
            SizedBox(height: 16),
            Text(
              '跟单中心',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '跟随专业交易员',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
