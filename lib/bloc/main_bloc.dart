import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koobit/api.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is GetQuestionDataEvent) {
      yield await _mapPostFetchedToState(state);
    } else if (event is NextQuestionEvent) {
      var nextIndex = state.questionIndex + 1;
      var temp = state.result;
      if(temp.isEmpty)
        temp = [event.userAnswer];
      else
        temp.add(event.userAnswer);
      if(nextIndex < state.question.length) {
        yield state.copyWith(questionIndex: state.questionIndex + 1,result: temp);
      }else
        yield state.copyWith(status: MainStatus.finish,result: temp);
    }else if(event is ReExamEvent){
      yield state.copyWith(status: MainStatus.exam,questionIndex: 0,result: []);
    }
  }

  Future<MainState> _mapPostFetchedToState(MainState state) async {
    final posts = await _fetchPostsQuestion();
    final posts2 = await _fetchPostsResult();
    return state.copyWith(question: posts, answer: posts2, questionIndex: 0,status: MainStatus.exam);
  }

  /// 從api取得題目
  Future<List<getData>> _fetchPostsQuestion() async {
    final response = await APi.getQuestions();
    return response;
  }

  /// 從api取得題目
  Future<List<submitData>> _fetchPostsResult() async {
    final response = await APi.submitQuestions();
    return response;
  }
}

// class MainBloc extends Bloc<MainEvent, MainState> {
//   MainBloc() : super(MainState());
//
//   @override
//   Stream<MainState> mapEventToState(MainState event) async* {
//     print("32312312");
//     if (event is GetQuestionDataEvent) {
//       print(4444);
//       yield await _mapPostFetchedToState(state);
//     }else if(event is NextQuestionEvent){
//       yield state.copyWith(questionIndex: state.questionIndex+1);
//     }
//   }
//
//   /// 更新新聞資料
//   /// * [state] 狀態
//   /// * [type] 新聞類型
//   ///
//   Future<MainState> _mapPostFetchedToState(MainState state) async {
//     print("1");
//     final posts = await _fetchPostsQuestion();
//     print('12');
//     final posts2 = await _fetchPostsResult();
//     print('123');
//     return state.copyWith(question: posts, answer: posts2, questionIndex: 0);
//   }
//
//   /// 從api取得題目
//   Future<List<getData>> _fetchPostsQuestion() async {
//     final response = await APi.getQuestions();
//     return response;
//   }
//
//   /// 從api取得題目
//   Future<List<submitData>> _fetchPostsResult() async {
//     final response = await APi.submitQuestions();
//     return response;
//   }
// }
