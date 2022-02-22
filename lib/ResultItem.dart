import 'package:flutter/cupertino.dart';

/// FileName ResultItem
///
/// @Author huangyangching
/// @Date 2022/2/22 5:03 下午
///
/// @Description TODO
///

class ResultItem extends StatelessWidget{

  final String question;
  final String result;
  final String onerResult;

  const ResultItem({ required this.question, required this.result, required this.onerResult});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var style = TextStyle(fontSize: 20);
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(question,style: style,),
          Text(result,style: style,),
          Text(onerResult,style: style,),
        ],
      ),
    );
  }

}