import 'package:cat_api/bloc/cats_repository.dart';
import 'package:cat_api/bloc/cats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class CatsCubit extends Cubit<CatsState> {
  final CatsRepository catsRepository;
  CatsCubit(this.catsRepository) : super(const CatsInitial()) {
    getCats();
  }

  Future<void> getCats() async {
    try {
      emit(const CatsLoading());
      await Future.delayed(const Duration(seconds: 3));
      final response = await catsRepository.getCatsFromApi();
      emit(CatsCompleted(response));
    } catch (e) {
      emit(CatsError(e.toString()));
    }
  }
}
