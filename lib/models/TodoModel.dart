/// userId : 1
/// id : 1
/// title : "delectus aut autem"
/// completed : false

class TodoModel {
  TodoModel({
      num? userId, 
      num? id, 
      String? title, 
      bool? completed,}){
    _userId = userId;
    _id = id;
    _title = title;
    _completed = completed;
}

  TodoModel.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _completed = json['completed'];
  }
  num? _userId;
  num? _id;
  String? _title;
  bool? _completed;
TodoModel copyWith({  num? userId,
  num? id,
  String? title,
  bool? completed,
}) => TodoModel(  userId: userId ?? _userId,
  id: id ?? _id,
  title: title ?? _title,
  completed: completed ?? _completed,
);
  num? get userId => _userId;
  num? get id => _id;
  String? get title => _title;
  bool? get completed => _completed;

  set completed(bool? value) {
    _completed = value;
  }


  set title(String? value) {
    _title = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['completed'] = _completed;
    return map;
  }

}