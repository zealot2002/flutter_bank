import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});

  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  @override
  void initState() {
    SimpleLogger.d('28', 'TradePage initState called');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('29', 'TradePage build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('交易'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_horiz, size: 64, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              '交易',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '现货交易',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
