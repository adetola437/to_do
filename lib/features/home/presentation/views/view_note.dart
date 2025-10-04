part of '../controllers/view_note.dart';

class ViewNoteView extends StatelessWidget implements ViewNoteViewContract {
  const ViewNoteView({super.key, required this.controller});

  final ViewNoteControllerContract controller;

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          20.verticalSpace,
          Row(
            children: [
              IconButton(onPressed: (){
                context.pop();
              }, icon: Icon(Icons.arrow_back, size: 26,)),

              Row(
                children: [
                  IconButton(onPressed: (){
                    context.read<NoteCubit>().deleteNote(controller.note!.id ?? '');
                  }, icon: Icon(Icons.delete, size: 26,color: Colors.red,)),
                  10.horizontalSpace,
                  IconButton(onPressed: (){
                      controller.edit();
                  }, icon: Icon(Icons.edit, size: 26,)),
                  10.horizontalSpace,
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.share, size: 26,)),
                  10.horizontalSpace,
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.folder_shared, size: 26,)),
                ],
              )
            ],
          ),20.verticalSpace,
(controller.note!.title ?? '').toText(fontSize: 26),
10.verticalSpace,
'Created at: ${controller.note!.createdAt!.toLocal()}'.toText(),
10.verticalSpace,
'Updated at: ${controller.note!.updatedAt!.toLocal()}'.toText(),
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
      )),
    );
  }

}
