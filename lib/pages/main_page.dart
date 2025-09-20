import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bank/utils/logger.dart';
import 'package:flutter_bank/pages/home_page.dart';
import 'package:flutter_bank/pages/market_page.dart';
import 'package:flutter_bank/pages/trade_page.dart';
import 'package:flutter_bank/pages/futures_page.dart';
import 'package:flutter_bank/pages/assets_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const HomePage(),
    const MarketPage(),
    const TradePage(),
    const FuturesPage(),
    const AssetsPage(),
  ];

  final List<String> _titles = [
    'LBank',
    '行情',
    '交易',
    '合约',
    '资产',
  ];

  @override
  void initState() {
    SimpleLogger.d('34', 'MainPage initState called');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('35', 'MainPage build called, currentIndex: $_currentIndex');
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          SimpleLogger.d('36', 'BottomNavigationBar tapped, index: $index');
          setState(() {
            _currentIndex = index;
          });
          SimpleLogger.d('37', 'Current page changed to: ${_titles[index]}');
          // 在下一帧渲染完成后输出日志
          SchedulerBinding.instance.addPostFrameCallback((_) {
            SimpleLogger.d('38', 'Frame rendered after setState');
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: 'LBank',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            activeIcon: Icon(Icons.trending_up),
            label: '行情',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            activeIcon: Icon(Icons.swap_horiz),
            label: '交易',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            activeIcon: Icon(Icons.account_balance),
            label: '合约',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: '资产',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
