import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/routes/app_routes.dart';
import 'package:notes/veiws/home/home_viewmodel.dart';
import 'package:notes/veiws/note_form/note_form_page.dart';
import 'package:notes/veiws/widgets/custom_chip.dart';
import 'package:notes/veiws/widgets/custom_search_delegate.dart';
import 'package:notes/veiws/widgets/note_list_tile.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.noteForm);
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, size: 30),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Row(
              children: [
                Row(
                  children: [
                    Obx(() {
                      return CustomChip(
                        isSelected: !controller.isSortedByTitle.value,
                        text: 'Sort by Date',
                        onSelect: controller.changeChip,
                      );
                    }),
                    SizedBox(width: 2),
                    Obx(() {
                      return CustomChip(
                        isSelected: controller.isSortedByTitle.value,
                        text: 'Sort by Title',
                        onSelect: controller.changeChip,
                      );
                    }),
                  ],
                ),
                Expanded(child: SizedBox()),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(
                            controller: controller,
                            onResultTap: (selectedNote) {
                              Get.to(() => NoteFormPage(note: selectedNote));
                            },
                          ),
                        );
                      },
                    ),
                    Obx(() {
                      return IconButton(
                        icon: Icon(
                          controller.isDarkMode.value
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          size: 3.h,
                        ),
                        onPressed: controller.changeTheme,
                      );
                    }),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
  child: Obx(() {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: controller.notes.length,
      itemBuilder: (context, index) {
        final note = controller.notes[index];
        return Dismissible(
          key: Key(note.id.toString()),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (direction) async {
            return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Delete Note"),
                content: Text("Are you sure you want to delete this note?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Delete"),
                  ),
                ],
              ),
            );
          },
          onDismissed: (_) {
            controller.deleteNoteWithUndo(context, note);
          },
          child: NoteListTile(
            note: note,
            onTap: () {
              Get.toNamed(
                AppRoutes.noteForm,
                arguments: note,
              )?.then((_) => controller.refreshNotes());
            },
          ),
        );
      },
    );
  }),
),
          ],
        ),
      ),
    );
  }
}
