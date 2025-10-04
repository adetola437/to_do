
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do/features/home/presentation/bloc/category/category_cubit.dart';

import '../data/model/note_category.dart';

class GeneralUtils{
     showAddCategoryDialog(VoidCallback onCategoryAdded, BuildContext context) {
    final nameController = TextEditingController();
    Color selectedColor = Colors.blue;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Add Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Choose Color', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                  Colors.purple,
                  Colors.orange,
                  Colors.pink,
                  Colors.teal,
                ].map((color) {
                  return GestureDetector(
                    onTap: () => setDialogState(() => selectedColor = color),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedColor == color
                              ? Colors.black
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  final newCategory = NoteCategory(
                    name: nameController.text,
                    color: selectedColor,
                  );
                  final success =
                      await GetIt.I.get<CategoryCubit>().addCategory(newCategory);
                  Navigator.pop(context);
                  if (success) {
                    onCategoryAdded();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Category added')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Category already exists')),
                    );
                  }
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}