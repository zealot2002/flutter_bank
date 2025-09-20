import 'package:flutter_bank/network/network_client.dart';
import 'package:flutter_bank/services/banner_service.dart';
import 'package:flutter_bank/services/user_service.dart';
import 'package:flutter_bank/services/trade_service.dart';
import 'package:flutter_bank/utils/logger.dart';

/// 网络管理器
class NetworkManager {
  static NetworkManager? _instance;
  
  // Service实例
  late final BannerService bannerService;
  late final UserService userService;
  late final TradeService tradeService;

  NetworkManager._();

  static NetworkManager get instance {
    _instance ??= NetworkManager._();
    return _instance!;
  }

  /// 初始化网络模块
  void init({
    String baseUrl = 'https://ccapi.lbk.world', // Debug环境默认使用测试域名
    Duration timeout = const Duration(seconds: 30),
    bool enableLogging = true,
  }) {
    SimpleLogger.d('1000', '=== 初始化网络模块 ===');
    SimpleLogger.d('1001', 'BaseURL: $baseUrl');
    SimpleLogger.d('1002', '超时时间: ${timeout.inSeconds}秒');
    SimpleLogger.d('1003', '启用日志: $enableLogging');

    // 初始化网络客户端
    NetworkClient.instance.init(NetworkConfig(
      baseUrl: baseUrl,
      timeout: timeout,
      enableLogging: enableLogging,
    ));

    // 初始化各个Service
    bannerService = BannerService();
    userService = UserService();
    tradeService = TradeService();

    SimpleLogger.d('1004', '=== 网络模块初始化完成 ===');
    SimpleLogger.d('1005', 'BannerService已初始化');
    SimpleLogger.d('1006', 'UserService已初始化');
    SimpleLogger.d('1007', 'TradeService已初始化');
  }

  /// 释放资源
  void dispose() {
    SimpleLogger.d('1008', '=== 释放网络模块资源 ===');
    NetworkClient.instance.dispose();
    SimpleLogger.d('1009', '网络模块资源已释放');
  }
}
