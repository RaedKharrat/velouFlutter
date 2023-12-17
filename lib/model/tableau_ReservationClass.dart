//tableau_ReservationClass.dart
class TableauReservationClass {
  final String idReservation;
  final String dateReservation;
  final String typePayment;
  final bool etat;
  final String idUser;
  final String idVelo;
  final String promoCode;
  final String stripeCheckoutSessionId;

  TableauReservationClass({
    required this.idReservation,
    required this.dateReservation,
    required this.typePayment,
    required this.etat,
    required this.idUser,
    required this.idVelo,
    required this.promoCode,
    required this.stripeCheckoutSessionId,
  });

  factory TableauReservationClass.fromJson(Map<String, dynamic> json) {
    return TableauReservationClass(
      idReservation: json['_id'].toString(),
      dateReservation: json['dateReservation'].toString(),
      typePayment: json['typePayment'].toString(),
      etat: json['etat'] as bool,
      idUser: json['idUser'].toString(),
      idVelo: json['idVelo'].toString(),
      promoCode: json['promoCode'].toString(),
      stripeCheckoutSessionId: json['stripeCheckoutSessionId'].toString(),
    );
  }

  // Add this getter
  String get shortDateReservation {
    // Assuming dateReservation is a String in the format 'yyyy-MM-ddTHH:mm:ss'
    return dateReservation.substring(0, 10);
  }
}
