part of '../controllers/create_task.dart';

class CreateTaskView extends StatelessWidget implements CreateTaskViewContract {
  const CreateTaskView({super.key, required this.controller});

  final CreateTaskControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteCreateSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
          // TODO: implement listener
        },
        child: SafeArea(
          child: Column(
            children: [
              QuillSimpleToolbar(
                controller: controller.controller!,
                config: QuillSimpleToolbarConfig(
                  customButtons: [
                    QuillToolbarCustomButtonOptions(
                      icon: const Icon(Icons.save),
                      onPressed: () {
                        Note? note= controller.note ?? Note();
                        note.quillContent =  jsonEncode(
                            controller.controller!.document.toDelta().toJson(),
                          );
                        context.read<CategoryCubit>().getCategories();
                        showSaveNoteModal(
                          context,note
                         
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: QuillEditor.basic(
                    controller: controller.controller!,
                    config: const QuillEditorConfig(
                      expands: true,
                      showCursor: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSaveNoteModal(BuildContext context, Note quillNote) {
   
    final titleController = TextEditingController();
    String? selectedCategory;
    Color selectedColor = Colors.lightBlue.shade100;
    final formKey = GlobalKey<FormState>();
 if (quillNote.quillContent!.isNotEmpty ) {
  log(quillNote.quillContent ?? '');
      titleController.text = quillNote.title ?? '';
      selectedCategory = quillNote.category;
      selectedColor = quillNote.color ??  Colors.lightBlue.shade100;
      
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
          
                    // Title
                    Text(
                      'Save Note',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
          
                    // Note Title Input
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        labelText: 'Note Title',
                        hintText: 'Enter note title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                      style: TextStyle(fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
          
                    // Categories Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            GeneralUtils().showAddCategoryDialog(() async {
                              // context.read<CategoryCubit>().getCategories();
                              // showSaveNoteModal(context, note);
                            }, context);
                          },
                          icon: Icon(Icons.add_circle_outline, size: 20),
                          label: Text('Add'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
          
                    // Category List
                    BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is CategoryLoaded) {
                          return Container(
                            constraints: BoxConstraints(maxHeight: 200),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.categories.length,
                              itemBuilder: (context, index) {
                                final category = state.categories[index];
                                final isSelected =
                                    category.name == selectedCategory;
          
                                return GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      selectedCategory = category.name;
                                      selectedColor = category.color.withOpacity(
                                        0.3,
                                      );
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? category.color.withOpacity(0.2)
                                          : Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? category.color
                                            : Colors.grey.shade200,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: category.color,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            category.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        if (isSelected)
                                          Icon(
                                            Icons.check_circle,
                                            color: category.color,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
          
                        return Center(child: Text('No Categories Found'));
                      },
                    ),
                    SizedBox(height: 24),
          
                    // Color Picker
                    Text(
                      'Note Color',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                              Colors.lightBlue.shade100,
                              Colors.pink.shade100,
                              Colors.yellow.shade100,
                              Colors.green.shade100,
                              Colors.purple.shade100,
                              Colors.orange.shade100,
                              Colors.teal.shade100,
                              Colors.indigo.shade100,
                            ].map((color) {
                              final isSelected = selectedColor == color;
                              return GestureDetector(
                                onTap: () =>
                                    setModalState(() => selectedColor = color),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Icon(Icons.check, color: Colors.black)
                                      : null,
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                    SizedBox(height: 24),
          
                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: BlocBuilder<NoteCubit, NoteState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){

                              if (titleController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter a title')),
                                );
                                return;
                              }
                            
          
                              final note = Note(
                                id: quillNote.id ?? DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                title: titleController.text,
                                category: selectedCategory ?? 'All',
                                quillContent: quillNote.quillContent,
                                createdAt:quillNote.createdAt ?? DateTime.now(),
                                updatedAt: DateTime.now(),
                                color: selectedColor,
                              );
          
                              context.read<NoteCubit>().createNote(note);
                              }
                            
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: 
                            state is NoteCreateLoading
                                ? CircularProgressIndicator()
                                :
                            Text(
                              'Save Note',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
