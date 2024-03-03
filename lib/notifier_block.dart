import 'package:flutter_bloc/flutter_bloc.dart';

sealed class BaseEvent {}

final class ChildItemClicked extends BaseEvent {
  String title;
  bool selected;
  ChildItemClicked({required this.title, this.selected = false}) {}
}

final class GrandChildItemClicked extends BaseEvent {
  String parentTitle;
  String title;
  bool selected = false;
  GrandChildItemClicked(
      {required this.parentTitle,
      required this.title,
      required this.selected}) {}
}

// Using Generics
class NotifierBlocData<Event extends BaseEvent, State extends Object> {
  Event event;
  State state;
  NotifierBlocData({required this.event, required this.state});
}

NotifierBlocData DEFFAULT_BLOCK_DATA = NotifierBlocData(
    event: ChildItemClicked(title: "Default Child"), state: "Default Data");

class NotifierBloc extends Bloc<BaseEvent, NotifierBlocData> {
  NotifierBloc() : super(DEFFAULT_BLOCK_DATA) {
    on<ChildItemClicked>(onChildClicked);
    on<GrandChildItemClicked>(onGrandChildClicked);
  }

  void onChildClicked(ChildItemClicked event, Emitter<NotifierBlocData> emit) {
    NotifierBlocData<ChildItemClicked, String> state =
        NotifierBlocData(event: event, state: "C ${event.title}");
    emit(state);
  }

  void onGrandChildClicked(
      GrandChildItemClicked event, Emitter<NotifierBlocData> emit) {
    NotifierBlocData<GrandChildItemClicked, String> state = NotifierBlocData(
        event: event, state: "GC ${event.parentTitle} ${event.title}");
    emit(state);
  }
}
