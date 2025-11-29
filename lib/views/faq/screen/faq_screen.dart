import 'package:doda_work/views/faq/model/faq_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../aditional/model/provider_register_model.dart' hide Data;
import '../controller/faq_controller.dart';

part 'faq_screen_mobile.dart';

class FaqScreen extends GetView<FaqController> {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: FaqScreenMobile());
  }
}
