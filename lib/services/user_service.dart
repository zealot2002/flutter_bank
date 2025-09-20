import 'package:flutter_bank/network/base_service.dart';
import 'package:flutter_bank/models/api_response.dart';
import 'package:flutter_bank/utils/logger.dart';

/// 用户信息模型
class UserInfo {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final bool isVerified;

  UserInfo({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    required this.isVerified,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'isVerified': isVerified,
    };
  }
}

/// 用户相关API服务
class UserService extends BaseService {
  @override
  String get moduleName => 'UserService';

  /// 获取用户信息
  Future<ApiResponse<UserInfo>> getUserInfo() async {
    SimpleLogger.d('800', '[$moduleName] 开始获取用户信息');
    
    return get<UserInfo>(
      '/user/info',
      fromJson: (data) => UserInfo.fromJson(data),
    );
  }

  /// 更新用户信息
  Future<ApiResponse<UserInfo>> updateUserInfo(UserInfo userInfo) async {
    SimpleLogger.d('801', '[$moduleName] 开始更新用户信息: ${userInfo.username}');
    
    return put<UserInfo>(
      '/user/info',
      body: userInfo.toJson(),
      fromJson: (data) => UserInfo.fromJson(data),
    );
  }

  /// 上传用户头像
  Future<ApiResponse<String>> uploadAvatar(String imagePath) async {
    SimpleLogger.d('802', '[$moduleName] 开始上传用户头像: $imagePath');
    
    return post<String>(
      '/user/avatar',
      body: {'imagePath': imagePath},
      fromJson: (data) => data as String,
    );
  }

  /// 获取用户资产信息
  Future<ApiResponse<Map<String, dynamic>>> getUserAssets() async {
    SimpleLogger.d('803', '[$moduleName] 开始获取用户资产信息');
    
    return get<Map<String, dynamic>>(
      '/user/assets',
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }
}
