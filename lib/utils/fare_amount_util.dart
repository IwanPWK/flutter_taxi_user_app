import 'package:intl/intl.dart';
import '../globals/global.dart';
import '../models/direction_details_info.dart';

class FareAmount {
  static String fareAmount = "";

  static double calculateFareAmountFromOriginToDestination(DirectionDetailsInfo directionDetailsInfo) {
    double timeTraveledFareAmountPerMinute = (directionDetailsInfo.durationValue! / 60) * 0.1;
    double distanceTraveledFareAmountPerKilometer = (directionDetailsInfo.distanceValue! / 1000) * 0.1;

    //USD
    double totalFareAmount = timeTraveledFareAmountPerMinute + distanceTraveledFareAmountPerKilometer;
    double localTotalFareAmount = totalFareAmount * 15000;

    return localTotalFareAmount;
  }

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static getFareAmountAccordingToVehicleType(int index) {
    double localTotalFareAmount = calculateFareAmountFromOriginToDestination(tripDirectionDetailsInfo!);

    if (tripDirectionDetailsInfo != null) {
      if (dList[index]["car_details"]["type"].toString() == "bike") {
        int roundedLocalTotalFareAmount = (localTotalFareAmount / 200).round() * 100;

        fareAmount = convertToIdr(roundedLocalTotalFareAmount, 2);
      }
      if (dList[index]["car_details"]["type"].toString() == "uber-x") //means executive type of car - more comfortable pro level

      {
        int roundedLocalTotalFareAmount = (localTotalFareAmount / 50).round() * 100;

        fareAmount = convertToIdr(roundedLocalTotalFareAmount, 2);
      }
      if (dList[index]["car_details"]["type"].toString() == "uber-go") // non - executive car - comfortable
      {
        int roundedLocalTotalFareAmount = (localTotalFareAmount / 100).round() * 100;

        fareAmount = convertToIdr(roundedLocalTotalFareAmount, 2);
      }
    }
    return fareAmount;
  }
}
