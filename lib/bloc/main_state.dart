part of 'main_bloc.dart';

enum MainStatus { init, exam, finish }

class MainState extends Equatable {
  final List<getData> question;
  final List<submitData> answer;
  final List<String> result;
  final int questionIndex;
  final MainStatus status;
  const MainState(
      {MainStatus? status,
      List<getData>? question,
      List<submitData>? answer,
      List<String>? result,
      int? questionIndex})
      : status = status ?? MainStatus.init,
        question = question ?? const <getData>[],
        answer = answer ?? const <submitData>[],
        result = result ?? const <String>[],
        questionIndex = questionIndex ?? -1;

  MainState copyWith(
      {MainStatus? status,
      List<getData>? question,
      List<submitData>? answer,
      List<String>? result,
      int? questionIndex}) {
    return MainState(
        status: status ?? this.status,
        question: question ?? this.question,
        answer: answer ?? this.answer,
        result: result ?? this.result,
        questionIndex: questionIndex ?? this.questionIndex);
  }

  @override
  List<Object> get props => [question, answer, result, questionIndex, status];
}
