import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'bottomnav_state.dart';

class BottomnavCubit extends Cubit<BottomnavState> {
  BottomnavCubit() : super(BottomnavInitial());
  int changeIndex(int index) {
    emit(BottomIndex(newIndex: index));
    return index;
  }
}
 