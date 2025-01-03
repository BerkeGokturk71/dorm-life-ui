class PostModel {
  int? id;
  String? task;
  String? food;
  String? soup;
  String? rice;
  String? salad;
  String? water;
  String? bread;

  PostModel(
      {this.id,
      this.task,
      this.food,
      this.soup,
      this.rice,
      this.salad,
      this.water,
      this.bread});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'];
    food = json['food'];
    soup = json['soup'];
    rice = json['rice'];
    salad = json['salad'];
    water = json['water'];
    bread = json['bread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['task'] = task;
    data['food'] = food;
    data['soup'] = soup;
    data['rice'] = rice;
    data['salad'] = salad;
    data['water'] = water;
    data['bread'] = bread;
    return data;
  }
}
