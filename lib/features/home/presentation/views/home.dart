// ignore_for_file: deprecated_member_use

part of '../controllers/home.dart';

class HomeView extends StatelessWidget implements HomeViewContract {
  const HomeView({super.key, required this.controller});

  final HomeControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NotesLoaded) {
            controller.setNotes(state.notes);
          }
          if (state is NoteDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Note deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is NoteDeleteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('An error occured deleting note'),
                backgroundColor: Colors.red,
              ),
            );
          }
          // TODO: implement listener
        },
        child: SafeArea(
          child: Padding(
            padding:REdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'My Note'.toText(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    ValueListenableBuilder(
                      valueListenable: themeNotifier,
                      builder: (context, value, child) {
                        log(value.brightness.toString(  ));
                         final isDark = value == darkTheme;
                        return Transform.scale(
                            scale: 0.6.sp,
                            child: Switch(
                              value: isDark,
                              onChanged: (newValue) async {
                                context.read<ThemeBloc>().add(ThemeToggleEvent()
                                      );
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          );
                      },
                      
                    )
                  ],
                ),
               16.verticalSpace,

                // Search bar
                TextField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for notes',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    controller.debounceSearch(value);
                  },
                ),
            16.verticalSpace,

                // Date selector
                SizedBox(
                  height: 80.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      final date = DateTime.now().add(Duration(days: index));
                      final isSelected =
                          date.day == controller.selectedDate!.day;
                      return _buildDateChip(date, isSelected);
                    },
                  ),
                ),
                 16.verticalSpace,

                // Category filters
                SizedBox(
                  height: 50.h,
                  child: BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is CategoryLoaded) {
                        return state.categories.isEmpty
                            ? Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('No Cateroies Found'),
                                    IconButton(
                                      onPressed: () {
                                        GeneralUtils().showAddCategoryDialog(
                                          () async {
                                            // context.read<CategoryCubit>().getCategories();
                                            // showSaveNoteModal(context, note);
                                          },
                                          context,
                                        );
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.categories.length,
                                itemBuilder: (context, index) {
                                  final category = state.categories[index];
                                  final isSelected =
                                      category.name.toLowerCase() ==
                                      controller.selectedCategory!
                                          .toLowerCase();
                                  return _buildCategoryChip(
                                    category,
                                    isSelected,
                                  );
                                },
                              );
                      }
                      return Center(child: 'No Categories Found'.toText());
                    },
                  ),
                ),
                16.verticalSpace,

                // Notes grid
                BlocBuilder<NoteCubit, NoteState>(
                  builder: (context, state) {
                    if (state is FetchingNotes) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is NotesLoaded) {
                      return Expanded(
                        child: state.notes.isEmpty
                            ? Center(child: "No Notes Found".toText())
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.85,
                                    ),
                                itemCount: state.notes.length,
                                itemBuilder: (context, index) {
                                  return _buildNoteCard(state.notes[index], context);
                                },
                              ),
                      );
                    }

                    return Expanded(
                      child: Center(child: 'No notes found'.toText()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.createTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDateChip(DateTime date, bool isSelected,) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Container(
      width: 70.h,
      margin: REdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            days[date.weekday - 1],
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
         4.verticalSpace,
          Text(
            '${date.day}',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(NoteCategory category, bool isSelected) {
    return GestureDetector(
      onTap: () {
        controller.setCategory(category);
      },
      child: Container(
        margin: REdgeInsets.only(right: 8),
        padding:REdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          category.name,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildNoteCard(Note note, BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.viewNote(note);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    note.title ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: context.designSystem.text ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.grey.shade700,
                  ),
                  onPressed: () {
                    if (note.id != null && note.id!.isNotEmpty) {
                      GetIt.I.get<NoteCubit>().deleteNote(note.id ?? '');
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: Text(
                controller.getPlainTextFromQuill(note.quillContent ?? ''),
                style: TextStyle(fontSize: 14, color: context.designSystem.text),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
