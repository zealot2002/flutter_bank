import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';
import 'package:flutter_bank/widgets/banner_view.dart';
import 'package:flutter_bank/viewmodels/banner_view_model.dart';

class OTCMainPage extends StatefulWidget {
  const OTCMainPage({super.key});

  @override
  State<OTCMainPage> createState() => _OTCMainPageState();
}

class _OTCMainPageState extends State<OTCMainPage> {
  final BannerViewModel _bannerViewModel = BannerViewModel();

  @override
  void initState() {
    super.initState();
    SimpleLogger.d('45', 'OTCMainPage initState called');
    _loadBannerData();
  }

  void _loadBannerData() async {
    SimpleLogger.d('170', '=== OTC页面开始加载Banner数据 ===');
    SimpleLogger.d('171', '当前页面状态: mounted=$mounted');
    
    await _bannerViewModel.loadP2pBannerList();
    
    SimpleLogger.d('172', 'Banner数据加载完成，检查页面状态');
    if (mounted) {
      SimpleLogger.d('173', '页面仍然mounted，调用setState更新UI');
      setState(() {
        SimpleLogger.d('174', 'setState执行完成，UI将重新构建');
      });
    } else {
      SimpleLogger.d('175', '页面已unmounted，跳过setState');
    }
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('46', 'OTCMainPage build called');
    
    return SingleChildScrollView(
      child: Column(
        children: [
          // Banner区域
          _buildBannerSection(),
          
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

  Widget _buildBannerSection() {
    SimpleLogger.d('180', '=== 构建Banner区域 ===');
    SimpleLogger.d('181', 'Banner状态: isLoading=${_bannerViewModel.isLoading}, errorMessage=${_bannerViewModel.errorMessage}');
    SimpleLogger.d('182', 'Banner数据条数: ${_bannerViewModel.bannerList.length}');
    
    if (_bannerViewModel.isLoading) {
      SimpleLogger.d('183', '显示加载中状态');
      return Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF2A2A2A),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      );
    }

    if (_bannerViewModel.errorMessage != null) {
      SimpleLogger.d('184', '显示错误状态: ${_bannerViewModel.errorMessage}');
      return Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF2A2A2A),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 24,
              ),
              const SizedBox(height: 8),
              const Text(
                '加载失败',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  _bannerViewModel.errorMessage!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  SimpleLogger.d('185', '用户点击重试按钮');
                  _loadBannerData();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('重试', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      );
    }

    final bannerData = _bannerViewModel.getBannerVoList();
    SimpleLogger.d('186', 'BannerVo数据条数: ${bannerData.length}');
    
    if (bannerData.isEmpty) {
      SimpleLogger.d('187', 'Banner数据为空，隐藏Banner区域');
      return const SizedBox.shrink();
    }

    SimpleLogger.d('188', '显示Banner轮播，数据条数: ${bannerData.length}');
    for (int i = 0; i < bannerData.length; i++) {
      final bannerVo = bannerData[i];
      SimpleLogger.d('189', 'BannerVo[$i]: imageUrl=${bannerVo.imageUrl}, content1=${bannerVo.content1}, content2=${bannerVo.content2}, link=${bannerVo.link}');
    }

    return BannerView(
      data: bannerData,
      height: 120,
      autoScroll: true,
      autoScrollDuration: const Duration(seconds: 4),
      onItemClick: (index) {
        SimpleLogger.d('190', '=== Banner点击事件 ===');
        SimpleLogger.d('191', '点击的Banner索引: $index');
        final banner = _bannerViewModel.bannerList[index];
        SimpleLogger.d('192', 'Banner详情: imgKey=${banner.imgKey}, title=${banner.title}, subTitle=${banner.subTitle}, linkUrl=${banner.linkUrl}');
        
        if (banner.linkUrl != null && banner.linkUrl!.isNotEmpty) {
          SimpleLogger.d('193', 'Banner有链接，可以处理点击事件: ${banner.linkUrl}');
          // 这里可以处理Banner点击事件，比如打开链接
        } else {
          SimpleLogger.d('194', 'Banner没有链接，跳过处理');
        }
      },
    );
  }
}
