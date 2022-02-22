import 'package:flutter/material.dart';
import 'package:koobit/ResultItem.dart';
import 'package:koobit/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// FileName homePage
///
/// @Author huangyangching
/// @Date 2022/2/22 3:42 下午
///
/// @Description TODO
///

class HomePage extends StatelessWidget {
  TextEditingController _textEditingControllercontroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        topWidget(),
        Expanded(
          child: BlocBuilder<MainBloc, MainState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status == MainStatus.exam)
                return quationWidget();
              else if (state.status == MainStatus.finish)
                return _HomeResultPage();
              else
                return Center();
            },
          ),
        )
      ],
    );
  }

  Widget topWidget() {
    return Container(
      width: double.infinity,
      color: Colors.blueAccent,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text("完成10道題目就可以解鎖獎勵"),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget quationWidget() {
    return Container(
      color: Colors.cyanAccent,
      width: double.infinity,
      padding: EdgeInsets.all(30),
      child: Container(
        decoration: BoxDecoration(
            //背景装饰
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.amberAccent),
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              //背景装饰
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.lightBlueAccent),
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: centerWidget(),
        ),
      ),
    );
  }

  Widget centerWidget() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("題目",
                  style: TextStyle(fontSize: 20, color: Colors.amberAccent)),
              SizedBox(
                width: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      //背景装饰
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.lightGreenAccent),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      return Text((state.questionIndex + 1).toString(),
                          style: TextStyle(fontSize: 18, color: Colors.white));
                    },
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              diffWidget(),
              numberWidget(),
            ],
          ),
          questionWidget()
        ],
      ),
    );
  }

  Widget diffWidget() {
    return Row(
      children: [
        Text("難度"),
        SizedBox(
          width: 3,
        ),
        Row(
          children: [
            difficultyRadiusWidget(1),
            SizedBox(
              width: 3,
            ),
            difficultyRadiusWidget(2),
            SizedBox(
              width: 3,
            ),
            difficultyRadiusWidget(3),
            SizedBox(
              width: 3,
            ),
            difficultyRadiusWidget(4),
            SizedBox(
              width: 3,
            ),
            difficultyRadiusWidget(5),
          ],
        )
      ],
    );
  }

  Widget difficultyRadiusWidget(int diff) {
    return BlocBuilder<MainBloc, MainState>(
      buildWhen: (previous, current) =>
          previous.questionIndex != current.questionIndex,
      builder: (context, state) {
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              //背景装饰
              borderRadius: BorderRadius.circular(30.0),
              color: state.questionIndex > -1 &&
                      state.question[state.questionIndex].difficulty < diff
                  ? Colors.white
                  : Colors.red),
        );
      },
    );
  }

  Widget numberWidget() {
    return Row(
      children: [
        Text("題目序號"),
        SizedBox(
          width: 5,
        ),
        BlocBuilder<MainBloc, MainState>(
          buildWhen: (previous, current) =>
              previous.questionIndex != current.questionIndex,
          builder: (context, state) {
            return Text(state.questionIndex > -1
                ? "${state.question[state.questionIndex].Id}"
                : "");
          },
        )
      ],
    );
  }

  Widget questionWidget() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            //背景装饰
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Text(
                      state.questionIndex > -1
                          ? state.question[state.questionIndex].question
                          : "",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: TextField(
                        controller: _textEditingControllercontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: '輸入答案',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      context.read<MainBloc>().add(NextQuestionEvent(
                          _textEditingControllercontroller.text));
                      _textEditingControllercontroller.text = "";
                    },
                    child: Text("確定"));
              },
            )
          ],
        ),
      ),
    );
  }
}

class _HomeResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var height = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(bottom: height),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? ResultItem(
                            question: "題目", result: "正確答案", onerResult: "您的答案")
                        : ResultItem(
                            question: state.question[index - 1].question,
                            result: state.answer[index - 1].answer.toString(),
                            onerResult: state.result[index - 1]);
                  },
                  itemCount: state.question.length + 1,
                  // controller: _scrollController,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 3);
                  },
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: () => context.read<MainBloc>().add(ReExamEvent()),
              child: Text("重新測驗")),
        ],
      ),
    );
  }
}
