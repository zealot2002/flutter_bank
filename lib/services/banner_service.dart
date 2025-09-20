import 'package:flutter_bank/network/base_service.dart';
import 'package:flutter_bank/models/api_response.dart';
import 'package:flutter_bank/models/banner_bean.dart';
import 'package:flutter_bank/utils/logger.dart';

/// Banner相关API服务
class BannerService extends BaseService {
  @override
  String get moduleName => 'BannerService';

  /// 获取P2P Banner列表
  /// 对应Android接口: /otc-trade-center/acceptant/v1/banners
  Future<ApiResponse<List<BannerBean>>> getP2pBannerList() async {
    SimpleLogger.d('700', '[$moduleName] 开始获取P2P Banner列表');
    
    return get<List<BannerBean>>(
      '/otc-trade-center/acceptant/v1/banners',
      fromJson: (data) => (data as List).map((item) => BannerBean.fromJson(item)).toList(),
    );
  }

  /// 获取首页Banner列表
  Future<ApiResponse<List<BannerBean>>> getHomeBannerList() async {
    SimpleLogger.d('701', '[$moduleName] 开始获取首页Banner列表');
    
    return get<List<BannerBean>>(
      '/home/banners',
      fromJson: (data) => (data as List).map((item) => BannerBean.fromJson(item)).toList(),
    );
  }

  /// 获取活动Banner列表
  Future<ApiResponse<List<BannerBean>>> getActivityBannerList() async {
    SimpleLogger.d('702', '[$moduleName] 开始获取活动Banner列表');
    
    return get<List<BannerBean>>(
      '/activity/banners',
      fromJson: (data) => (data as List).map((item) => BannerBean.fromJson(item)).toList(),
    );
  }

  /// 记录Banner点击事件
  Future<ApiResponse<void>> recordBannerClick(String bannerId) async {
    SimpleLogger.d('703', '[$moduleName] 记录Banner点击: $bannerId');
    
    return post<void>(
      '/banner/click',
      body: {'bannerId': bannerId},
    );
  }
}
