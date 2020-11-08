import 'package:flutter_bloc/flutter_bloc.dart';

class IsLoading extends Cubit<bool> {
  IsLoading() : super(false);

  void loading(bool loading) => emit(loading);
}
