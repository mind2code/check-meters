class LocalData {
  int? id, sync;
  String? data;

  LocalData({this.id, this.data, this.sync});

  Map<String, dynamic> toJson() => {
    "id": id,
    "sync": sync,
    "data": data
  };

}