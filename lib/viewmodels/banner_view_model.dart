import 'package:flutter_bank/models/banner_bean.dart';
import 'package:flutter_bank/models/api_response.dart';
import 'package:flutter_bank/network/network_manager.dart';
import 'package:flutter_bank/utils/logger.dart';

import '../widgets/banner_view.dart';

/// Banner数据管理ViewModel
class BannerViewModel {
  List<BannerBean> _bannerList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<BannerBean> get bannerList => _bannerList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 获取P2P Banner列表
  Future<void> loadP2pBannerList() async {
    SimpleLogger.d('140', '=== BannerViewModel开始加载数据 ===');
    SimpleLogger.d('141', '当前状态: isLoading=$_isLoading, errorMessage=$_errorMessage, bannerCount=${_bannerList.length}');
    
    _isLoading = true;
    _errorMessage = null;
    
    try {
      SimpleLogger.d('142', '调用BannerService获取Banner数据');
      
      // 使用新的BannerService
      final response = await NetworkManager.instance.bannerService.getP2pBannerList();
      
      SimpleLogger.d('143', '=== API调用完成 ===');
      SimpleLogger.d('144', 'API响应成功: ${response.success}');
      SimpleLogger.d('145', 'API响应码: ${response.code}');
      SimpleLogger.d('146', 'API响应消息: ${response.message}');
      SimpleLogger.d('147', 'API响应数据: ${response.data}');
      
      if (response.success && response.data != null) {
        _bannerList = response.data!;
        SimpleLogger.d('148', '=== Banner数据更新成功 ===');
        SimpleLogger.d('149', 'Banner数据条数: ${_bannerList.length}');
        
        for (int i = 0; i < _bannerList.length; i++) {
          final banner = _bannerList[i];
          SimpleLogger.d('150', 'Banner[$i]详情: imgKey=${banner.imgKey}, title=${banner.title}, subTitle=${banner.subTitle}, linkUrl=${banner.linkUrl}');
        }
        
        // 转换为BannerVo格式
        final bannerVoList = getBannerVoList();
        SimpleLogger.d('151', '转换为BannerVo格式，条数: ${bannerVoList.length}');
        
        for (int i = 0; i < bannerVoList.length; i++) {
          final bannerVo = bannerVoList[i];
          SimpleLogger.d('152', 'BannerVo[$i]: imageUrl=${bannerVo.imageUrl}, content1=${bannerVo.content1}, content2=${bannerVo.content2}, link=${bannerVo.link}');
        }
      } else {
        _errorMessage = response.message;
        SimpleLogger.e('153', '=== Banner数据加载失败 ===');
        SimpleLogger.e('154', '失败原因: ${response.message}');
        SimpleLogger.e('155', 'API响应码: ${response.code}');
      }
    } catch (e) {
      _errorMessage = '加载失败: $e';
      SimpleLogger.e('156', '=== Banner数据加载异常 ===');
      SimpleLogger.e('157', '异常类型: ${e.runtimeType}');
      SimpleLogger.e('158', '异常信息: $e');
    } finally {
      _isLoading = false;
      SimpleLogger.d('159', '=== BannerViewModel加载完成 ===');
      SimpleLogger.d('160', '最终状态: isLoading=$_isLoading, errorMessage=$_errorMessage, bannerCount=${_bannerList.length}');
    }
  }

  /// 转换为BannerVo格式
  List<BannerVo> getBannerVoList() {
    return _bannerList.map((bean) => bean.toBannerVo()).toList();
  }

  /// 清空数据
  void clear() {
    _bannerList.clear();
    _errorMessage = null;
    _isLoading = false;
  }
}
