enum PaymentStatus { connected, completed, error }

extension PaymentStatusParser on PaymentStatus {
  String value() {
    return this.toString().split('.').last;
  }

//static keyword for class level methors with can be accessed without creating an object
  static PaymentStatus fromString(String status) {
    return PaymentStatus.values
        .firstWhere((element) => element.value() == status);
  }
}

class PaymentWebSocketEntity {
  PaymentStatus paymentStatus;
  PaymentWebSocketEntity({required this.paymentStatus});

  factory PaymentWebSocketEntity.fromJson(Map<String, dynamic> json) {
    return PaymentWebSocketEntity(
        paymentStatus: PaymentStatusParser.fromString(json['status']));
  }
}
