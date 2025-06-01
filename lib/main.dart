import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes/core/service/database_service.dart';
import 'package:notes/core/theme/app_theme.dart';
import 'package:notes/routes/app_pages.dart';
import 'package:notes/routes/app_routes.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DatabaseService().init());
  await GetStorage.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final isDark = box.read('isDarkMode') ?? false;
    return Sizer(
      builder: (context, orientation, screenType){
        return GetMaterialApp(
        title:  'Notes',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: isDark?ThemeMode.dark:ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
      );
      },
    );
  }
}
