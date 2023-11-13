class AttriubuteAddModel {
  dynamic id;
  dynamic value;
  dynamic quantity;
  String image;
  dynamic price;
  dynamic discount;
  AttriubuteAddModel(
      {required this.id,
      required this.value,
      required this.quantity,
      required this.image,
      this.price,
      this.discount});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'quantity': quantity,
      'image': image,
      'discount': discount,
      'price': price,
      
    };
  }
}
