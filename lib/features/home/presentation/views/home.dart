// ignore_for_file: deprecated_member_use

part of '../controllers/home.dart';

class HomeView extends StatelessWidget implements HomeViewContract {
  const HomeView({super.key, required this.controller});

  final HomeControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NotesLoaded) {
            controller.setNotes(state.notes);
          }
          // TODO: implement listener
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Note',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                  ],
                ),
                SizedBox(height: 16),

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
                    controller.onChangedValue(value);
                  },
                ),
                SizedBox(height: 16),

                // Date selector
                SizedBox(
                  height: 80,
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
                SizedBox(height: 16),

                // Category filters
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.defaultCategories!.length,
                    itemBuilder: (context, index) {
                      final category = controller.defaultCategories![index];
                      final isSelected =
                          category.name == controller.selectedCategory;
                      return _buildCategoryChip(category, isSelected);
                    },
                  ),
                ),
                SizedBox(height: 16),

                // Notes grid
                BlocBuilder<NoteCubit, NoteState>(
                  builder: (context, state) {
                    if (state is FetchingNotes) {
                      return Center(child: CircularProgressIndicator());
                    }
                     if (state is NotesLoaded){
  return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: state.notes.length,
                        itemBuilder: (context, index) {
                          return _buildNoteCard(
                           state.notes[index],
                          );
                        },
                      ),
                    );
                     }
                   
                  return Expanded(child: Center(
                    child:
                    Text('No notes found')));
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

  Widget _buildDateChip(DateTime date, bool isSelected) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Container(
      width: 70,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          SizedBox(height: 4),
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
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(20),
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

  Widget _buildNoteCard(Note note) {
    return GestureDetector(
      onTap: () {
        controller.viewNote(note);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.edit, size: 20, color: Colors.grey.shade700),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: Text(
                controller.getPlainTextFromQuill(note.quillContent),
                style: TextStyle(fontSize: 14),
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
