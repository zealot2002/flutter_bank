import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

/// Banner数据模型
class BannerVo {
  final String? imageUrl;
  final String? content1;
  final String? content2;
  final String? link;

  BannerVo({
    this.imageUrl,
    this.content1,
    this.content2,
    this.link,
  });
}

/// BannerView组件
class BannerView extends StatefulWidget {
  final List<BannerVo> data;
  final double height;
  final Duration autoScrollDuration;
  final bool autoScroll;
  final Function(int position)? onItemClick;

  const BannerView({
    super.key,
    required this.data,
    this.height = 120.0,
    this.autoScrollDuration = const Duration(seconds: 4),
    this.autoScroll = true,
    this.onItemClick,
  });

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    SimpleLogger.d('47', 'BannerView initState called');
    
    _pageController = PageController();
    
    if (widget.autoScroll && widget.data.length > 1) {
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (mounted) {
        int nextIndex = (_currentIndex + 1) % widget.data.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    SimpleLogger.d('48', 'BannerView页面切换到: $index');
  }

  void _onItemTap(int index) {
    SimpleLogger.d('49', 'BannerView点击项目: $index');
    widget.onItemClick?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: widget.height,
      child: Stack(
        children: [
          // PageView for banner items
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              final item = widget.data[index];
              return GestureDetector(
                onTap: () => _onItemTap(index),
                child: _BannerItem(
                  data: item,
                  height: widget.height,
                ),
              );
            },
          ),
          
          // 指示器
          if (widget.data.length > 1)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.data.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index 
                          ? Colors.white 
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Banner项目组件
class _BannerItem extends StatelessWidget {
  final BannerVo data;
  final double height;

  const _BannerItem({
    required this.data,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFF2A2A2A),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            // 背景图片
            if (data.imageUrl != null && data.imageUrl!.isNotEmpty)
              Positioned.fill(
                child: Image.network(
                  data.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF2A2A2A),
                      child: const Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 40,
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                color: const Color(0xFF2A2A2A),
                child: const Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            
            // 渐变遮罩
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
            
            // 文本内容
            Positioned(
              left: 16,
              right: 16,
              top: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  if (data.content1 != null && data.content1!.isNotEmpty)
                    Text(
                      data.content1!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: data.content2?.isNotEmpty == true ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  
                  const SizedBox(height: 4),
                  
                  // 描述
                  if (data.content2 != null && data.content2!.isNotEmpty)
                    Text(
                      data.content2!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
