import 'package:flutter/material.dart';
import '../models/note.dart';
import '../widgets/glass_note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void addNote() {
    if (titleController.text.isEmpty || contentController.text.isEmpty) return;

    setState(() {
      notes.add(
        Note(
          title: titleController.text,
          content: contentController.text,
        ),
      );
    });

    titleController.clear();
    contentController.clear();
    Navigator.pop(context);
  }

  void openDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("New Note ✨"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(hintText: "Content"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: addNote,
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    int crossAxisCount = 1;
    if (width > 600) crossAxisCount = 2;
    if (width > 1000) crossAxisCount = 3;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text("Glass Notes"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openDialog,
        child: const Icon(Icons.add),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF263B55),
              Color(0xFF243B55),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: notes.isEmpty
            ? const Center(
          child: Text(
            "No Notes Yet ✨",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        )
            : GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 3,
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return GlassNoteCard(
              note: notes[index],
              onDelete: () {
                setState(() {
                  notes.removeAt(index);
                });
              },
            );
          },
        ),
      ),
    );
  }
}