import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';
import 'package:flutter_bank/network/network_manager.dart';
import 'package:flutter_bank/viewmodels/banner_view_model.dart';

class TestNetworkPage extends StatefulWidget {
  const TestNetworkPage({super.key});

  @override
  State<TestNetworkPage> createState() => _TestNetworkPageState();
}

class _TestNetworkPageState extends State<TestNetworkPage> {
  final BannerViewModel _bannerViewModel = BannerViewModel();
  String _testResult = '';

  @override
  void initState() {
    super.initState();
    SimpleLogger.d('400', 'TestNetworkPage initState called');
  }

  Future<void> _testSuccessRequest() async {
    setState(() {
      _testResult = '测试BannerService成功请求中...';
    });
    
    SimpleLogger.d('401', '=== 开始测试BannerService成功请求 ===');
    
    try {
      final response = await NetworkManager.instance.bannerService.getP2pBannerList();
      
      setState(() {
        _testResult = 'BannerService请求完成！\n'
            '响应码: ${response.code}\n'
            '响应消息: ${response.message}\n'
            '响应成功: ${response.success}\n'
            '数据条数: ${response.data?.length ?? 0}';
      });
      
      SimpleLogger.d('402', 'BannerService请求测试完成');
    } catch (e) {
      setState(() {
        _testResult = 'BannerService请求测试失败: $e';
      });
      SimpleLogger.e('403', 'BannerService请求测试异常: $e');
    }
  }

  Future<void> _testErrorRequest() async {
    setState(() {
      _testResult = '测试UserService请求中...';
    });
    
    SimpleLogger.d('404', '=== 开始测试UserService请求 ===');
    
    try {
      final response = await NetworkManager.instance.userService.getUserInfo();
      
      setState(() {
        _testResult = 'UserService请求完成！\n'
            '响应码: ${response.code}\n'
            '响应消息: ${response.message}\n'
            '响应成功: ${response.success}\n'
            '用户信息: ${response.data?.username ?? "无"}';
      });
      
      SimpleLogger.d('405', 'UserService请求测试完成');
    } catch (e) {
      setState(() {
        _testResult = 'UserService请求测试失败: $e';
      });
      SimpleLogger.e('406', 'UserService请求测试异常: $e');
    }
  }

  Future<void> _testBannerViewModel() async {
    setState(() {
      _testResult = '测试BannerViewModel中...';
    });
    
    SimpleLogger.d('407', '=== 开始测试BannerViewModel ===');
    
    try {
      await _bannerViewModel.loadP2pBannerList();
      
      setState(() {
        _testResult = 'BannerViewModel测试完成！\n'
            '加载状态: ${_bannerViewModel.isLoading}\n'
            '错误信息: ${_bannerViewModel.errorMessage ?? "无"}\n'
            'Banner条数: ${_bannerViewModel.bannerList.length}';
      });
      
      SimpleLogger.d('408', 'BannerViewModel测试完成');
    } catch (e) {
      setState(() {
        _testResult = 'BannerViewModel测试失败: $e';
      });
      SimpleLogger.e('409', 'BannerViewModel测试异常: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('410', 'TestNetworkPage build called');

    return Scaffold(
      appBar: AppBar(
        title: const Text('网络请求测试'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '网络请求日志测试',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: _testSuccessRequest,
              child: const Text('测试BannerService'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: _testErrorRequest,
              child: const Text('测试UserService'),
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
