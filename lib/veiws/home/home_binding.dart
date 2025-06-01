import 'package:get/get.dart';
import 'package:notes/veiws/home/home_viewmodel.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(()=>HomeController());
  }
}