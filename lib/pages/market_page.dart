import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  void initState() {
    SimpleLogger.d('26', 'MarketPage initState called');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('27', 'MarketPage build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('行情'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.trending_up, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text(
              '行情',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '实时行情数据',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
