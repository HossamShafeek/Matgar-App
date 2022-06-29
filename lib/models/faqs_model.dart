class FaqsModel{
  bool status;
  Data data;
  FaqsModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data= json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data{
  List<FaqsDetails> faqsDetails=[];
  Data.fromJson(Map<String,dynamic>json){
    if (json['data'] != null) {
      json['data'].forEach((v) {
        faqsDetails.add(FaqsDetails.fromJson(v));
      });
    }
  }
}

class FaqsDetails{
  int id;
  String question;
  String answer;
  FaqsDetails.fromJson(Map<String,dynamic>json){
    id=json['id'];
    question=json['question'];
    answer=json['answer'];
  }
}