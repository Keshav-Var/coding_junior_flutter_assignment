import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/model/note_model.dart';
import 'package:notes/routes/app_routes.dart';
import 'package:notes/veiws/home/home_viewmodel.dart';
import 'package:notes/veiws/widgets/note_list_tile.dart';

class CustomSearchDelegate extends SearchDelegate {
  final HomeController controller;
  final Function(Note) onResultTap;

  CustomSearchDelegate({required this.controller, required this.onResultTap});

  @override
  String get searchFieldLabel => 'Search';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Note>>(
      future: controller.searchNotes(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final filtered = snapshot.data ?? [];

        if (filtered.isEmpty) {
          return const Center(child: Text('No results found.'));
        }

        return Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final note = filtered[index];
          
              return NoteListTile(
                note: note,
                onTap: () {
                  Get.offAndToNamed(AppRoutes.noteForm, arguments: note);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filtered =
        controller.notes
            .where(
              (note) =>
                  note.title.toLowerCase().contains(query.toLowerCase()) ||
                  note.content.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final note = filtered[index];
          return NoteListTile(
            note: note,
            onTap: () {
              Get.offAndToNamed(AppRoutes.noteForm, arguments: note);
            },
          );
        },
      ),
    );
  }
}
