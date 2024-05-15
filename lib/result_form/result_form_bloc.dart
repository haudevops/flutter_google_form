import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'result_form_event.dart';
part 'result_form_state.dart';

class ResultFormBloc extends Bloc<ResultFormEvent, ResultFormState> {
  ResultFormBloc() : super(ResultFormInitial()) {
    on<ResultFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
