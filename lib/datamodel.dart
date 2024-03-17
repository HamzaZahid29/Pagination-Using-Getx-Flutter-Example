class DataModel{
  int Id;
  String title;
  String  body;

  DataModel({required this.Id,required this.title,required this.body});
  factory DataModel.fromJson(Map<String, dynamic> json){
    return DataModel(
      Id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}