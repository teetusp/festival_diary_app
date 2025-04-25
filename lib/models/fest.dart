class Fest {
  int? festId;
  String? festName;
  String? festDetail;
  String? festState;
  double? festCost;
  int? userId;
  String? festImage;
  int? festNumDay;

  Fest(
      {this.festId,
      this.festName,
      this.festDetail,
      this.festState,
      this.festCost,
      this.userId,
      this.festImage,
      this.festNumDay});

  Fest.fromJson(Map<String, dynamic> json) {
    festId = json['festId'];
    festName = json['festName'];
    festDetail = json['festDetail'];
    festState = json['festState'];
    festCost = double.parse(json['festCost'].toString());
    userId = json['userId'];
    festImage = json['festImage'];
    festNumDay = json['festNumDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['festId'] = this.festId;
    data['festName'] = this.festName;
    data['festDetail'] = this.festDetail;
    data['festState'] = this.festState;
    data['festCost'] = this.festCost;
    data['userId'] = this.userId;
    data['festImage'] = this.festImage;
    data['festNumDay'] = this.festNumDay;
    return data;
  }
}
