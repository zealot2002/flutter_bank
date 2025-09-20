import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class OTCMainPage extends StatefulWidget {
  const OTCMainPage({super.key});

  @override
  State<OTCMainPage> createState() => _OTCMainPageState();
}

class _OTCMainPageState extends State<OTCMainPage> {
  @override
  void initState() {
    super.initState();
    SimpleLogger.d('45', 'OTCMainPage initState called');
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('46', 'OTCMainPage build called');
    
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 64,
            color: Colors.blue,
          ),
          SizedBox(height: 16),
          Text(
            'OTC购买',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '场外交易功能',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
