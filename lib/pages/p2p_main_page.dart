import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

class P2PMainPage extends StatefulWidget {
  const P2PMainPage({super.key});

  @override
  State<P2PMainPage> createState() => _P2PMainPageState();
}

class _P2PMainPageState extends State<P2PMainPage> {
  @override
  void initState() {
    super.initState();
    SimpleLogger.d('50', 'P2PMainPage initState called');
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('51', 'P2PMainPage build called');
    
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people,
            size: 64,
            color: Colors.blue,
          ),
          SizedBox(height: 16),
          Text(
            'P2P交易',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '点对点交易功能',
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
