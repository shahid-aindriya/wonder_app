class AttriubuteAddModel {
  dynamic Id;
  dynamic value;
  dynamic quantity;
  dynamic image;

  AttriubuteAddModel({
    required this.Id,
    required this.value,
    required this.quantity,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'value': value,
      'quantity': quantity,
      'image': image,
    };
  }
}
