import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/model/note_model.dart';
import 'package:notes/veiws/note_form/noteform_view_model.dart';
import 'package:sizer/sizer.dart';

class NoteFormPage extends StatefulWidget {
  final Note? note;
  const NoteFormPage({super.key, this.note});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NoteFormController>();
    final now = DateTime.now();
    final formattedDate = DateFormat('d MMMM').format(now);
    final formattedTime = DateFormat('hh:mm a').format(now);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),

            /// Back Button
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),

            /// Title Field with yellow underline
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                controller: controller.titleController,
                style: Theme.of(context).textTheme.headlineSmall,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// Timestamp and character count
            Obx(
              () => Text(
                '$formattedDate  $formattedTime   |  ${controller.characterCount}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 24),

            /// Content Field
            Expanded(
              child: TextField(
                controller: controller.contentController,
                onChanged: controller.updateCharacterCount,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Start typing',
                  border: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Call your save function here
                  await controller.saveNote();
                },
                icon: const Icon(Icons.save_alt, size: 20),
                label: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 12,
                  ),
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
