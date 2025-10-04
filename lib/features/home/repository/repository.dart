


import 'dart:convert';

import '../../../core/data/model/note.dart';
import '../../../core/data/model/note_category.dart';
import '../../../core/storage/storage_client.dart';

abstract class HomeRepository {
  Future<bool?> isDarkMode();
   Future<bool?> getVisibility();
  Future<void> toggleTheme(bool isDark);
    Future<void> saveVisibility(bool isVisible);
  Future<bool?> isBiometric();
  Future<void> toggleBiometric(bool value);
  Future<List<Note>> loadNotes();
  Future<bool> saveNote(Note note);
  Future<bool> deleteNote(String noteId);
  Future<List<Note>> getNotesByCategory(String category);
   Future<List<NoteCategory>> loadCategories();
  Future<bool> addCategory(NoteCategory category);
  Future<bool> deleteCategory(String categoryName); 
  // Future<List<Note>> searchNotes(String query);

}

class HomeRepositoryImpl implements HomeRepository {
  final StorageClient storageClient;

  HomeRepositoryImpl(this.storageClient, );

  @override
  Future<bool?> isDarkMode() async {
    return storageClient.read<bool>("darkTheme");
  }

  @override
  Future<void> toggleTheme(bool isDark) async {
    storageClient.write<bool>("darkTheme", isDark);
  }

  @override
  Future<bool?> isBiometric() async {
    return storageClient.read<bool>("biometric");
  }

  @override
  Future<void> toggleBiometric(bool value) async {
    storageClient.write<bool>("biometric", value);
  }


  
  @override
  Future<bool?> getVisibility() async{   
    return await storageClient.read<bool>("visibility");
  }
  
  @override
  Future<void> saveVisibility(bool isVisible)async {
storageClient.write<bool>("visibility", isVisible);
  }

@override
     Future<List<Note>> loadNotes() async {
    try {

      final notesString = await storageClient.read<String>("notes_list");
      
      if (notesString == null || notesString.isEmpty) {
        return [];
      }

      final List<dynamic> notesJsonList = jsonDecode(notesString);
      return notesJsonList.map((json) => Note.fromJson(json)).toList();
    } catch (e) {
      print('Error loading notes: $e');
      return [];
    }
  }

  // Save a single note
  @override
   Future<bool> saveNote(Note note) async {
    try {
      final notes = await loadNotes();
      final index = notes.indexWhere((n) => n.id == note.id);
      
      if (index != -1) {
        notes[index] = note;
      } else {
        notes.add(note);
      }
      
      return await saveNotes(notes);
    } catch (e) {
      print('Error saving note: $e');
      return false;
    }
  }

    @override
   Future<bool> deleteNote(String noteId) async {
    try {
      final notes = await loadNotes();
      notes.removeWhere((n) => n.id == noteId);
      return await saveNotes(notes);
    } catch (e) {
      print('Error deleting note: $e');
      return false;
    }
  }



  @override
   Future<List<Note>> getNotesByCategory(String category) async {
    try {
      final notes = await loadNotes();
      if (category == 'All') {
        return notes;
      }
      return notes.where((n) => n.category == category).toList();
    } catch (e) {
      print('Error getting notes by category: $e');
      return [];
    }
  }

  Future<bool> saveNotes(List<Note> notes) async {
    try {

      final notesJsonList = notes.map((note) => note.toJson()).toList();
      final notesString = jsonEncode(notesJsonList);
    return await  storageClient.write<String>("notes_list", notesString);
 
    } catch (e) {
      print('Error saving notes: $e');
      return false;
    }
  }


  //  Future<List<Note>> searchNotes(String query) async {
  //   try {
  //     final notes = await loadNotes();
  //     return notes
  //         .where((n) =>
  //             n.title.toLowerCase().contains(query.toLowerCase()) ||
  //             _getPlainTextFromQuill(n.quillContent)
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()))
  //         .toList();
  //   } catch (e) {
  //     print('Error searching notes: $e');
  //     return [];
  //   }
  // }


    Future<bool> saveCategories(List<NoteCategory> categories) async {
    try {
     
      final categoriesJsonList = categories.map((cat) => cat.toJson()).toList();
      final categoriesString = jsonEncode(categoriesJsonList);
       return await  storageClient.write<String>("categories_list", categoriesString);
    } catch (e) {
      print('Error saving categories: $e');
      return false;
    }
  }

  @override
   Future<List<NoteCategory>> loadCategories() async {
    try {
      
      final categoriesString = await storageClient.read<String>("categories_list");
      
      if (categoriesString == null || categoriesString.isEmpty) {
        // Return default categories if none saved
        return [];
      }

      final List<dynamic> categoriesJsonList = jsonDecode(categoriesString);
      return categoriesJsonList.map((json) => NoteCategory.fromJson(json)).toList();
    } catch (e) {
      print('Error loading categories: $e');
      return [];
    }
  }

  // Add a new category
   Future<bool> addCategory(NoteCategory category) async {
    try {
      final categories = await loadCategories();
      
      // Check if category already exists
      if (categories.any((c) => c.name.toLowerCase() == category.name.toLowerCase())) {
        print('Category already exists');
        return false;
      }
      
      categories.add(category);
      return await saveCategories(categories);
    } catch (e) {
      print('Error adding category: $e');
      return false;
    }
  }



  // Delete a category
   Future<bool> deleteCategory(String categoryName) async {
    try {
     
      if (categoryName == 'All') {
        print('Cannot delete All category');
        return false;
      }
      
      final categories = await loadCategories();
      categories.removeWhere((c) => c.name == categoryName);
      
      // Move notes from deleted category to 'Personal'
      final notes = await loadNotes();
      for (var note in notes) {
        if (note.category == categoryName) {
          final updatedNote = note.copyWith(category: 'Personal');
          await saveNote(updatedNote);
        }
      }
      
      return await saveCategories(categories);
    } catch (e) {
      print('Error deleting category: $e');
      return false;
    }
  }

}
