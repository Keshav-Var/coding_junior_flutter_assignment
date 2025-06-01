import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/model/note_model.dart';

class NoteListTile extends StatelessWidget {
  final Note note;
  final VoidCallback? onTap;

  const NoteListTile({super.key, required this.note, this.onTap});

  String getFormattedDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return DateFormat.jm().format(date); // 10:01 PM
    } else {
      return DateFormat.yMMMMd().format(date); // May 14, 2024
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              note.content,
              style: theme.textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              getFormattedDate(note.updatedAt),
              style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
