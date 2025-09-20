import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class BuyCoinPage extends StatefulWidget {
  const BuyCoinPage({super.key});

  @override
  State<BuyCoinPage> createState() => _BuyCoinPageState();
}

class _BuyCoinPageState extends State<BuyCoinPage> {
  @override
  void initState() {
    super.initState();
    SimpleLogger.d('41', 'BuyCoinPage initState called');
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('42', 'BuyCoinPage build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('买币'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text(
              '买币中心',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '快速购买数字货币',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
