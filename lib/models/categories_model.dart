class CategoriesModel {
  bool? status;

  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? CategoriesDataModel.fromJson(json['data'])
        : null;
  }
}

class CategoriesDataModel {
  List<DataModel>? data;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    // if (json['data'] != null) {
    data = <DataModel>[];
    json['data'].forEach((v) {
      data!.add(DataModel.fromJson(v));
    });
    // }
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  get data => null;
}
