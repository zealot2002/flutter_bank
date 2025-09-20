import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';
import 'package:flutter_bank/widgets/banner_view.dart';
import 'package:flutter_bank/viewmodels/banner_view_model.dart';

class P2PMainPage extends StatefulWidget {
  const P2PMainPage({super.key});

  @override
  State<P2PMainPage> createState() => _P2PMainPageState();
}

class _P2PMainPageState extends State<P2PMainPage> {
  final BannerViewModel _bannerViewModel = BannerViewModel();

  @override
  void initState() {
    super.initState();
    SimpleLogger.d('50', 'P2PMainPage initState called');
    _loadBannerData();
  }

  void _loadBannerData() async {
    SimpleLogger.d('200', '=== P2P页面开始加载Banner数据 ===');
    SimpleLogger.d('201', '当前页面状态: mounted=$mounted');
    
    await _bannerViewModel.loadP2pBannerList();
    
    SimpleLogger.d('202', 'Banner数据加载完成，检查页面状态');
    if (mounted) {
      SimpleLogger.d('203', '页面仍然mounted，调用setState更新UI');
      setState(() {
        SimpleLogger.d('204', 'setState执行完成，UI将重新构建');
      });
    } else {
      SimpleLogger.d('205', '页面已unmounted，跳过setState');
    }
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('51', 'P2PMainPage build called');
    
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
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    SimpleLogger.d('210', '=== 构建Banner区域 ===');
    SimpleLogger.d('211', 'Banner状态: isLoading=${_bannerViewModel.isLoading}, errorMessage=${_bannerViewModel.errorMessage}');
    SimpleLogger.d('212', 'Banner数据条数: ${_bannerViewModel.bannerList.length}');
    
    if (_bannerViewModel.isLoading) {
      SimpleLogger.d('213', '显示加载中状态');
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
      SimpleLogger.d('214', '显示错误状态: ${_bannerViewModel.errorMessage}');
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
                  SimpleLogger.d('215', '用户点击重试按钮');
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
    SimpleLogger.d('216', 'BannerVo数据条数: ${bannerData.length}');
    
    if (bannerData.isEmpty) {
      SimpleLogger.d('217', 'Banner数据为空，隐藏Banner区域');
      return const SizedBox.shrink();
    }

    SimpleLogger.d('218', '显示Banner轮播，数据条数: ${bannerData.length}');
    for (int i = 0; i < bannerData.length; i++) {
      final bannerVo = bannerData[i];
      SimpleLogger.d('219', 'BannerVo[$i]: imageUrl=${bannerVo.imageUrl}, content1=${bannerVo.content1}, content2=${bannerVo.content2}, link=${bannerVo.link}');
    }

    return BannerView(
      data: bannerData,
      height: 120,
      autoScroll: true,
      autoScrollDuration: const Duration(seconds: 4),
      onItemClick: (index) {
        SimpleLogger.d('220', '=== Banner点击事件 ===');
        SimpleLogger.d('221', '点击的Banner索引: $index');
        final banner = _bannerViewModel.bannerList[index];
        SimpleLogger.d('222', 'Banner详情: imgKey=${banner.imgKey}, title=${banner.title}, subTitle=${banner.subTitle}, linkUrl=${banner.linkUrl}');
        
        if (banner.linkUrl != null && banner.linkUrl!.isNotEmpty) {
          SimpleLogger.d('223', 'Banner有链接，可以处理点击事件: ${banner.linkUrl}');
          // 这里可以处理Banner点击事件，比如打开链接
        } else {
          SimpleLogger.d('224', 'Banner没有链接，跳过处理');
        }
      },
    );
  }
}
