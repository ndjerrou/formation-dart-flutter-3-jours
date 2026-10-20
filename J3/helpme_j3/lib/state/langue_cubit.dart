import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/local_store.dart';

class LangueCubit extends Cubit<String> {
  LangueCubit(this.store) : super(store.langue);
  final LocalStore store;
  Future<void> changer(String langue) async {
    await store.sauverLangue(langue);
    emit(langue);
  }
}
