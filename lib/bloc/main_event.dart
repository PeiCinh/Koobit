part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
  @override
  List<Object> get props => [];
}

class GetQuestionDataEvent extends MainEvent {
  const GetQuestionDataEvent();

}

class NextQuestionEvent extends MainEvent {
  const NextQuestionEvent(this.userAnswer);
  final String userAnswer;
}

class ReExamEvent extends MainEvent {
  const ReExamEvent();

}
