import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';
import 'package:flutter_bank/pages/otc_main_page.dart';
import 'package:flutter_bank/pages/p2p_main_page.dart';

class BuyCoinPage extends StatefulWidget {
  const BuyCoinPage({super.key});

  @override
  State<BuyCoinPage> createState() => _BuyCoinPageState();
}

class _BuyCoinPageState extends State<BuyCoinPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SimpleLogger.d('41', 'BuyCoinPage initState called');
    
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
    
    // 监听Tab切换
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('42', 'BuyCoinPage build called');
    
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // 深色背景
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // 移除原来的title，通过flexibleSpace来放置TabBar相关内容，更灵活控制布局
        flexibleSpace: Container(
          padding: const EdgeInsets.only(left: 36, top: 15), // 留出返回按钮的宽度，并调整垂直位置
          alignment: Alignment.centerLeft, // 整体靠左对齐
          child: Row(
            mainAxisSize: MainAxisSize.min, // 关键：使Row只占用所需的最小宽度
            children: [
              // 紧凑型Tab，宽度只容纳文本
              GestureDetector(
                onTap: () {
                  _tabController.animateTo(0);
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  // 去掉背景和边框
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Text(
                    '快捷买币',
                    style: TextStyle(
                      color: _currentIndex == 0 ? Colors.white : Colors.grey, // 选中白色，未选中灰色
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10), // 两个Tab之间的间距
              GestureDetector(
                onTap: () {
                  _tabController.animateTo(1);
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  // 去掉背景和边框
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Text(
                    'P2P交易',
                    style: TextStyle(
                      color: _currentIndex == 1 ? Colors.white : Colors.grey, // 选中白色，未选中灰色
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          OTCMainPage(),
          P2PMainPage(),
        ],
      ),
    );
  }
}
