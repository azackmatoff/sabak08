class TempHelper {
  double calvinToCelcius(num calvin) {
    if (calvin is int) {
      return ((calvin.toDouble()) - 273.15).roundToDouble();
    } else {
      return (calvin - 273.15).roundToDouble();
    }
  }
}
