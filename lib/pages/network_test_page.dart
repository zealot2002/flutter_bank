import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';
import 'package:flutter_bank/network/network_manager.dart';
import 'package:flutter_bank/viewmodels/banner_view_model.dart';

class NetworkTestPage extends StatefulWidget {
  const NetworkTestPage({super.key});

  @override
  State<NetworkTestPage> createState() => _NetworkTestPageState();
}

class _NetworkTestPageState extends State<NetworkTestPage> {
  final BannerViewModel _bannerViewModel = BannerViewModel();
  String _testResult = '';

  @override
  void initState() {
    super.initState();
    SimpleLogger.d('1100', 'NetworkTestPage initState called');
  }

  Future<void> _testBannerService() async {
    setState(() {
      _testResult = '测试BannerService中...';
    });
    
    SimpleLogger.d('1101', '=== 开始测试BannerService ===');
    
    try {
      final response = await NetworkManager.instance.bannerService.getP2pBannerList();
      
      setState(() {
        _testResult = 'BannerService测试完成！\n'
            '响应码: ${response.code}\n'
            '响应消息: ${response.message}\n'
            '响应成功: ${response.success}\n'
            '数据条数: ${response.data?.length ?? 0}';
      });
      
      SimpleLogger.d('1102', 'BannerService测试完成');
    } catch (e) {
      setState(() {
        _testResult = 'BannerService测试失败: $e';
      });
      SimpleLogger.e('1103', 'BannerService测试异常: $e');
    }
  }

  Future<void> _testUserService() async {
    setState(() {
      _testResult = '测试UserService中...';
    });
    
    SimpleLogger.d('1104', '=== 开始测试UserService ===');
    
    try {
      final response = await NetworkManager.instance.userService.getUserInfo();
      
      setState(() {
        _testResult = 'UserService测试完成！\n'
            '响应码: ${response.code}\n'
            '响应消息: ${response.message}\n'
            '响应成功: ${response.success}\n'
            '用户信息: ${response.data?.username ?? "无"}';
      });
      
      SimpleLogger.d('1105', 'UserService测试完成');
    } catch (e) {
      setState(() {
        _testResult = 'UserService测试失败: $e';
      });
      SimpleLogger.e('1106', 'UserService测试异常: $e');
    }
  }

  Future<void> _testTradeService() async {
    setState(() {
      _testResult = '测试TradeService中...';
    });
    
    SimpleLogger.d('1107', '=== 开始测试TradeService ===');
    
    try {
      final response = await NetworkManager.instance.tradeService.getTradingPairs();
      
      setState(() {
        _testResult = 'TradeService测试完成！\n'
            '响应码: ${response.code}\n'
            '响应消息: ${response.message}\n'
            '响应成功: ${response.success}\n'
            '交易对数量: ${response.data?.length ?? 0}';
      });
      
      SimpleLogger.d('1108', 'TradeService测试完成');
    } catch (e) {
      setState(() {
        _testResult = 'TradeService测试失败: $e';
      });
      SimpleLogger.e('1109', 'TradeService测试异常: $e');
    }
  }

  Future<void> _testBannerViewModel() async {
    setState(() {
      _testResult = '测试BannerViewModel中...';
    });
    
    SimpleLogger.d('1110', '=== 开始测试BannerViewModel ===');
    
    try {
      await _bannerViewModel.loadP2pBannerList();
      
      setState(() {
        _testResult = 'BannerViewModel测试完成！\n'
            '加载状态: ${_bannerViewModel.isLoading}\n'
            '错误信息: ${_bannerViewModel.errorMessage ?? "无"}\n'
            'Banner条数: ${_bannerViewModel.bannerList.length}';
      });
      
      SimpleLogger.d('1111', 'BannerViewModel测试完成');
    } catch (e) {
      setState(() {
        _testResult = 'BannerViewModel测试失败: $e';
      });
      SimpleLogger.e('1112', 'BannerViewModel测试异常: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('1113', 'NetworkTestPage build called');

    return Scaffold(
      appBar: AppBar(
        title: const Text('网络架构测试'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '分层网络请求架构测试',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: _testBannerService,
              child: const Text('测试BannerService'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: _testUserService,
              child: const Text('测试UserService'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: _testTradeService,
              child: const Text('测试TradeService'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: _testBannerViewModel,
              child: const Text('测试BannerViewModel'),
            ),
            const SizedBox(height: 20),
            
            const Text(
              '测试结果:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _testResult.isEmpty ? '点击上方按钮开始测试' : _testResult,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            const Text(
              '查看控制台日志了解详细请求过程',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
