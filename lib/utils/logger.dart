import 'package:flutter/foundation.dart';

/// 简单的日志工具，仅包装debugPrint方法
class SimpleLogger {
  static const String _tag = 'zzy';
  
  /// 记录调试日志
  static void d(String no, String message) {
    _log('DEBUG', no, message);
  }

  /// 记录错误日志
  static void e(String no, String message) {
    _log('ERROR', no, message);
  }
  
  /// 内部日志方法
  static void _log(String level, String no, String message) {
    final logMessage = '[$_tag][$level][$no] $message';
    debugPrint(logMessage);
  }
}
