import '../widgets/banner_view.dart';

/// Banner数据模型，对应Android的BannerBean
class BannerBean {
  final String? imgKey;
  final String? title;
  final String? subTitle;
  final String? linkUrl;

  BannerBean({
    this.imgKey,
    this.title,
    this.subTitle,
    this.linkUrl,
  });

  factory BannerBean.fromJson(Map<String, dynamic> json) {
    return BannerBean(
      imgKey: json['imgKey'],
      title: json['title'],
      subTitle: json['subTitle'],
      linkUrl: json['linkUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imgKey': imgKey,
      'title': title,
      'subTitle': subTitle,
      'linkUrl': linkUrl,
    };
  }

  /// 转换为BannerVo格式
  BannerVo toBannerVo() {
    return BannerVo(
      imageUrl: imgKey,
      content1: title,
      content2: subTitle,
      link: linkUrl,
    );
  }
}
