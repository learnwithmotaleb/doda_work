// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsDummyGen {
  const $AssetsDummyGen();

  /// File path: assets/dummy/Car wash-rafiki 1.svg
  String get carWashRafiki1 => 'assets/dummy/Car wash-rafiki 1.svg';

  /// File path: assets/dummy/Frame.svg
  String get frame => 'assets/dummy/Frame.svg';

  /// File path: assets/dummy/Group 14928.svg
  String get group14928 => 'assets/dummy/Group 14928.svg';

  /// File path: assets/dummy/Inbox cleanup-amico 1.svg
  String get inboxCleanupAmico1 => 'assets/dummy/Inbox cleanup-amico 1.svg';

  /// File path: assets/dummy/Message.svg
  String get message => 'assets/dummy/Message.svg';

  /// File path: assets/dummy/Mobile login-rafiki 1.svg
  String get mobileLoginRafiki1 => 'assets/dummy/Mobile login-rafiki 1.svg';

  /// File path: assets/dummy/Tablet login-amico 1.svg
  String get tabletLoginAmico1 => 'assets/dummy/Tablet login-amico 1.svg';

  /// File path: assets/dummy/otp.svg
  String get otp => 'assets/dummy/otp.svg';

  /// File path: assets/dummy/phone.svg
  String get phone => 'assets/dummy/phone.svg';

  /// File path: assets/dummy/servicesAuth1.svg
  String get servicesAuth1 => 'assets/dummy/servicesAuth1.svg';

  /// File path: assets/dummy/streamline-ultimate-color_self-payment-touch.svg
  String get streamlineUltimateColorSelfPaymentTouch =>
      'assets/dummy/streamline-ultimate-color_self-payment-touch.svg';

  /// List of all assets
  List<String> get values => [
    carWashRafiki1,
    frame,
    group14928,
    inboxCleanupAmico1,
    message,
    mobileLoginRafiki1,
    tabletLoginAmico1,
    otp,
    phone,
    servicesAuth1,
    streamlineUltimateColorSelfPaymentTouch,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Frame (1).svg
  String get frame1 => 'assets/icons/Frame (1).svg';

  /// File path: assets/icons/Green.svg
  String get green => 'assets/icons/Green.svg';
  String get home => 'assets/icons/home.svg';

  /// File path: assets/icons/Group.svg
  String get group => 'assets/icons/Group.svg';

  /// File path: assets/icons/Popup.svg
  String get popup => 'assets/icons/Popup.svg';

  /// File path: assets/icons/Vector.svg
  String get vector => 'assets/icons/Vector.svg';

  /// File path: assets/icons/activity.svg
  String get activity => 'assets/icons/activity.svg';

  /// File path: assets/icons/category.svg
  String get category => 'assets/icons/category.svg';

  /// File path: assets/icons/empty.svg
  String get empty => 'assets/icons/empty.svg';

  /// File path: assets/icons/paper-plane-top 1.svg
  String get paperPlaneTop1 => 'assets/icons/paper-plane-top 1.svg';

  /// File path: assets/icons/picture 1.svg
  String get picture1 => 'assets/icons/picture 1.svg';

  /// File path: assets/icons/reject.svg
  String get reject => 'assets/icons/reject.svg';

  /// File path: assets/icons/request 1.svg
  String get request1 => 'assets/icons/request 1.svg';

  /// File path: assets/icons/success.svg
  String get success => 'assets/icons/success.svg';

  /// File path: assets/icons/verified.svg
  String get verified => 'assets/icons/verified.svg';

  /// File path: assets/icons/vuesax.svg
  String get vuesax => 'assets/icons/vuesax.svg';

  /// List of all assets
  List<String> get values => [
    frame1,
    home,
    green,
    group,
    popup,
    vector,
    activity,
    category,
    empty,
    paperPlaneTop1,
    picture1,
    reject,
    request1,
    success,
    verified,
    vuesax,
  ];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/Page-1.svg
  String get page1 => 'assets/logo/Page-1.svg';

  /// File path: assets/logo/aaplogo.png
  AssetGenImage get aaplogo => const AssetGenImage('assets/logo/aaplogo.png');

  /// File path: assets/logo/appLogo.svg
  String get appLogo => 'assets/logo/appLogo.svg';

  /// File path: assets/logo/forground.png
  AssetGenImage get forground =>
      const AssetGenImage('assets/logo/forground.png');

  /// File path: assets/logo/google.svg
  String get google => 'assets/logo/google.svg';

  /// File path: assets/logo/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/logo/logo.png');

  /// List of all assets
  List<dynamic> get values => [
    page1,
    aaplogo,
    appLogo,
    forground,
    google,
    logo,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsDummyGen dummy = $AssetsDummyGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
