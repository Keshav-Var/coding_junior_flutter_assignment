import 'package:get/get.dart';
import 'package:notes/splash.dart';
import 'package:notes/veiws/home/home_page.dart';
import 'package:notes/veiws/home/home_binding.dart';
import 'package:notes/veiws/note_form/note_form_page.dart';
import 'package:notes/veiws/note_form/note_form_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.noteForm,
      page: () => NoteFormPage(),
      binding: NoteFormBinding(),
    ),
    GetPage(name: AppRoutes.splash, page: ()=>Splash()),
  ];
}
