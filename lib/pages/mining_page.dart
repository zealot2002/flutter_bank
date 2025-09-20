import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class MiningPage extends StatefulWidget {
  const MiningPage({super.key});

  @override
  State<MiningPage> createState() => _MiningPageState();
}

class _MiningPageState extends State<MiningPage> {
  @override
  void initState() {
    super.initState();
    SimpleLogger.d('39', 'MiningPage initState called');
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('40', 'MiningPage build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('挖矿'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.diamond, size: 64, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              '挖矿中心',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '开始您的挖矿之旅',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
