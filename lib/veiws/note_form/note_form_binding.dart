import 'package:get/get.dart';
import 'package:notes/veiws/note_form/noteform_view_model.dart';

class NoteFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteFormController>(() => NoteFormController());
  }
}
