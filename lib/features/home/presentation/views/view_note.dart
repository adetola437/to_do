part of '../controllers/view_note.dart';

class ViewNoteView extends StatelessWidget implements ViewNoteViewContract {
  const ViewNoteView({super.key, required this.controller});

  final ViewNoteControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if(state is NoteDeleteSuccess){
         
            context.pop();
            
          }
          // TODO: implement listener
        },
        child: SafeArea(
          child: Padding(
            padding: REdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(Icons.arrow_back, size: 26),
                    ),

                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<NoteCubit>().deleteNote(
                              controller.note!.id ?? '',
                            );
                          },
                          icon: Icon(Icons.delete, size: 26, color: Colors.red),
                        ),
                        10.horizontalSpace,
                        IconButton(
                          onPressed: () {
                            controller.edit();
                          },
                          icon: Icon(Icons.edit, size: 26),
                        ),
                        10.horizontalSpace,
                        IconButton(
                          onPressed: () {
                            NoteActionsService.shareNote(controller.note ?? Note());
                          },
                          icon: Icon(Icons.share, size: 26),
                        ),
                        10.horizontalSpace,
                        IconButton(
                          onPressed: () {
                              NoteActionsService.exportAndSharePdf(controller.note ?? Note());
                          },
                          icon: Icon(Icons.folder_shared, size: 26),
                        ),
                      ],
                    ),
                  ],
                ),
                20.verticalSpace,
                (controller.note!.title ?? '').toText(fontSize: 26),
                10.verticalSpace,
                'Created at: ${DateFormat.yMMMMEEEEd().format(controller.note!.createdAt ?? DateTime.now())}'
                    .toText(),
                10.verticalSpace,
                'Updated at: ${DateFormat.yMMMMEEEEd().format(controller.note!.updatedAt ?? DateTime.now())}'
                    .toText(),
                20.verticalSpace,

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
      ),
    );
  }
}
