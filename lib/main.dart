import 'package:firebase_core/firebase_core.dart';

import 'core/utils/basic_import.dart';
import 'firebase_options.dart';
import 'initial.dart';
import 'routes/routes.dart';
import 'views/splash/controller/splash_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initial.init();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      designSize: const Size(375, 812),
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        title: Strings.appName,
        theme: Themes.light,
        darkTheme: Themes.dark,
        getPages: Routes.list,
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 300),
        themeMode: ThemeMode.light,
        initialBinding: BindingsBuilder(() {
          Get.lazyPut(() => SplashController());
        }),
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: Directionality(
              textDirection: Get.locale?.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: widget!,
            ),
          );
        },
      ),
    );
  }
}

//dart run build_runner build
