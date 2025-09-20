import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class WelfarePage extends StatefulWidget {
  const WelfarePage({super.key});

  @override
  State<WelfarePage> createState() => _WelfarePageState();
}

class _WelfarePageState extends State<WelfarePage> {
  @override
  void initState() {
    super.initState();
    SimpleLogger.d('45', 'WelfarePage initState called');
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('46', 'WelfarePage build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('福利中心'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_giftcard, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              '福利中心',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '领取专属福利',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
