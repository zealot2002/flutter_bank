import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';
import 'package:flutter_bank/pages/main_page.dart';
import 'package:flutter_bank/network/network_manager.dart';

void main() {
  SimpleLogger.d('1', '=== Flutter Bank App Starting ===');
  SimpleLogger.d('2', 'main() function called');
  
  // 初始化网络模块
  NetworkManager.instance.init(
    baseUrl: 'https://ccapi.lbk.world', // Debug环境使用测试域名
    timeout: const Duration(seconds: 30),
    enableLogging: true,
  );
  
  try {
    SimpleLogger.d('3', 'About to call runApp()');
    runApp(const MyApp());
    SimpleLogger.d('4', 'runApp() called successfully');
  } catch (e) {
    SimpleLogger.e('5', 'Error in main(): $e');
    rethrow;
  }
  
  SimpleLogger.d('6', '=== main() function completed ===');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('7', 'MyApp.build() called');
    SimpleLogger.d('8', 'Creating MaterialApp widget');
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(),
      onGenerateRoute: (settings) {
        SimpleLogger.d('9', 'onGenerateRoute called: ${settings.name}');
        return null;
      },
      builder: (context, child) {
        SimpleLogger.d('10', 'MaterialApp builder called');
        return child!;
      },
    );
  }
}

