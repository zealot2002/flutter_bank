import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';
import 'package:flutter_bank/pages/mining_page.dart';
import 'package:flutter_bank/pages/buy_coin_page.dart';
import 'package:flutter_bank/pages/copy_trade_page.dart';
import 'package:flutter_bank/pages/welfare_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    SimpleLogger.d('24', 'HomePage initState called');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('25', 'HomePage build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('LBank'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 欢迎区域
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.yellow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(Icons.home, size: 48, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    '欢迎来到LBank',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '您的数字资产交易平台',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 金刚区标题
            const Text(
              '快捷功能',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 金刚区网格
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildDiamondCard(
                  context,
                  icon: Icons.diamond,
                  title: '挖矿',
                  subtitle: '开始挖矿',
                  color: Colors.orange,
                  onTap: () => _navigateToPage(context, const MiningPage()),
                ),
                _buildDiamondCard(
                  context,
                  icon: Icons.shopping_cart,
                  title: '买币',
                  subtitle: '快速买币',
                  color: Colors.green,
                  onTap: () => _navigateToPage(context, const BuyCoinPage()),
                ),
                _buildDiamondCard(
                  context,
                  icon: Icons.copy,
                  title: '跟单',
                  subtitle: '跟随交易',
                  color: Colors.purple,
                  onTap: () => _navigateToPage(context, const CopyTradePage()),
                ),
                _buildDiamondCard(
                  context,
                  icon: Icons.card_giftcard,
                  title: '福利中心',
                  subtitle: '领取福利',
                  color: Colors.red,
                  onTap: () => _navigateToPage(context, const WelfarePage()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiamondCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    SimpleLogger.d('47', 'Navigating to page: ${page.runtimeType}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
