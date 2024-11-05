import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppBuild {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    ResponsiveSizingConfig.instance.setCustomBreakpoints(
        const ScreenBreakpoints(desktop: 1440, tablet: 768, watch: 240));
  }
}
