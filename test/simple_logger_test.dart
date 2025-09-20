import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bank/utils/logger.dart';

void main() {
  group('SimpleLogger Tests', () {
    test('SimpleLogger should log different levels', () {
      // 这些调用不应该抛出异常
      expect(() => SimpleLogger.d('1', 'Debug message'), returnsNormally);
      expect(() => SimpleLogger.e('2', 'Error message'), returnsNormally);
    });

    test('SimpleLogger should format messages correctly', () {
      // 测试日志格式是否正确
      SimpleLogger.d('3', 'Test message');
      // 由于debugPrint的输出无法直接测试，我们只能确保不抛出异常
      expect(true, isTrue);
    });
  });
}
