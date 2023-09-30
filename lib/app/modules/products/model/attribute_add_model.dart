class AttriubuteAddModel {
  dynamic id;
  dynamic value;
  dynamic quantity;
  String image;

  AttriubuteAddModel({
    required this.id,
    required this.value,
    required this.quantity,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'quantity': quantity,
      'image': image,
    };
  }
}
