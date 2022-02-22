import 'dart:ffi';

/// FileName api
///
/// @Author huangyangching
/// @Date 2022/2/22 12:29 下午
///
/// @Description TODO
///
///

class APi {
  static Future<List<getData>> getQuestions() async {
    return [
      getData(1000, "1+1=", 1),
      getData(1001, "1+2=", 2),
      getData(1002, "1+3=", 3),
      getData(1003, "1+4=", 4),
      getData(1004, "1+5=", 5)
    ];
  }

  static Future<List<submitData>> submitQuestions() async {
    return [
      submitData(1000, 2),
      submitData(1001, 3),
      submitData(1002, 4),
      submitData(1003, 5),
      submitData(1004, 6),
    ];
  }
}

class getData {
  int Id;
  String question;
  int difficulty;

  getData(this.Id, this.question, this.difficulty);
}

class submitData {
  int Id;
  int answer;
  submitData(this.Id, this.answer);
}
