import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';
import 'package:flutter_bank/widgets/banner_view.dart';

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
    
    // 模拟Banner数据
    final bannerData = [
      BannerVo(
        imageUrl: 'https://via.placeholder.com/400x120/FF6B6B/FFFFFF?text=Banner+1',
        content1: '新用户专享',
        content2: '注册即送100USDT体验金',
        link: 'https://www.lbank.info',
      ),
      BannerVo(
        imageUrl: 'https://via.placeholder.com/400x120/4ECDC4/FFFFFF?text=Banner+2',
        content1: '限时优惠',
        content2: '交易手续费低至0.1%',
        link: 'https://www.lbank.info',
      ),
      BannerVo(
        imageUrl: 'https://via.placeholder.com/400x120/45B7D1/FFFFFF?text=Banner+3',
        content1: '安全可靠',
        content2: '全球领先的数字资产交易平台',
        link: 'https://www.lbank.info',
      ),
    ];
    
    return SingleChildScrollView(
      child: Column(
        children: [
          // Banner区域
          BannerView(
            data: bannerData,
            height: 120,
            autoScroll: true,
            autoScrollDuration: const Duration(seconds: 4),
            onItemClick: (index) {
              SimpleLogger.d('50', 'Banner点击: $index');
              // 这里可以处理Banner点击事件
            },
          ),
          
          const SizedBox(height: 20),
          
          // 其他内容
          const Center(
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
          ),
        ],
      ),
    );
  }
}
