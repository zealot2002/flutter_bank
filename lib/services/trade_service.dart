import 'package:flutter_bank/network/base_service.dart';
import 'package:flutter_bank/models/api_response.dart';
import 'package:flutter_bank/utils/logger.dart';

/// 交易对信息模型
class TradingPair {
  final String symbol;
  final String baseAsset;
  final String quoteAsset;
  final double price;
  final double change24h;
  final double volume24h;

  TradingPair({
    required this.symbol,
    required this.baseAsset,
    required this.quoteAsset,
    required this.price,
    required this.change24h,
    required this.volume24h,
  });

  factory TradingPair.fromJson(Map<String, dynamic> json) {
    return TradingPair(
      symbol: json['symbol'] ?? '',
      baseAsset: json['baseAsset'] ?? '',
      quoteAsset: json['quoteAsset'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      change24h: (json['change24h'] ?? 0.0).toDouble(),
      volume24h: (json['volume24h'] ?? 0.0).toDouble(),
    );
  }
}

/// 交易相关API服务
class TradeService extends BaseService {
  @override
  String get moduleName => 'TradeService';

  /// 获取交易对列表
  Future<ApiResponse<List<TradingPair>>> getTradingPairs() async {
    SimpleLogger.d('900', '[$moduleName] 开始获取交易对列表');
    
    return get<List<TradingPair>>(
      '/trade/pairs',
      fromJson: (data) => (data as List).map((item) => TradingPair.fromJson(item)).toList(),
    );
  }

  /// 获取K线数据
  Future<ApiResponse<List<Map<String, dynamic>>>> getKlineData(
    String symbol,
    String interval,
    int limit,
  ) async {
    SimpleLogger.d('901', '[$moduleName] 开始获取K线数据: $symbol, $interval, $limit');
    
    return get<List<Map<String, dynamic>>>(
      '/trade/klines',
      queryParams: {
        'symbol': symbol,
        'interval': interval,
        'limit': limit.toString(),
      },
      fromJson: (data) => (data as List).cast<Map<String, dynamic>>(),
    );
  }

  /// 获取深度数据
  Future<ApiResponse<Map<String, dynamic>>> getDepthData(String symbol) async {
    SimpleLogger.d('902', '[$moduleName] 开始获取深度数据: $symbol');
    
    return get<Map<String, dynamic>>(
      '/trade/depth',
      queryParams: {'symbol': symbol},
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  /// 下单
  Future<ApiResponse<Map<String, dynamic>>> placeOrder(Map<String, dynamic> orderData) async {
    SimpleLogger.d('903', '[$moduleName] 开始下单: $orderData');
    
    return post<Map<String, dynamic>>(
      '/trade/order',
      body: orderData,
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  /// 取消订单
  Future<ApiResponse<void>> cancelOrder(String orderId) async {
    SimpleLogger.d('904', '[$moduleName] 开始取消订单: $orderId');
    
    return delete<void>(
      '/trade/order/$orderId',
    );
  }

  /// 获取订单历史
  Future<ApiResponse<List<Map<String, dynamic>>>> getOrderHistory({
    String? symbol,
    int? limit,
    int? offset,
  }) async {
    SimpleLogger.d('905', '[$moduleName] 开始获取订单历史');
    
    return get<List<Map<String, dynamic>>>(
      '/trade/orders',
      queryParams: {
        if (symbol != null) 'symbol': symbol,
        if (limit != null) 'limit': limit.toString(),
        if (offset != null) 'offset': offset.toString(),
      },
      fromJson: (data) => (data as List).cast<Map<String, dynamic>>(),
    );
  }
}
