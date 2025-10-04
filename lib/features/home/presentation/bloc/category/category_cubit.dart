import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do/features/home/repository/repository.dart';

import '../../../../../core/data/model/note_category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  HomeRepository repository;
  CategoryCubit({required this.repository}) : super(CategoryInitial());

  addCategory(NoteCategory category)async{
    try {
      emit(CategoryLoading());
      await repository.addCategory(category);
   emit(CategoryLoaded(await repository.loadCategories()));
    } catch (e) {
      
    }
  }

  getCategories()async{
    try {
      emit(CategoryLoading());
   emit(CategoryLoaded(await repository.loadCategories()));
    } catch (e) {
      
    }
  }
}
