int convert(dynamic sundayBasedDay) {
  /// to convert from system where sunday is first day of week into
  /// system where monday is first
  if (sundayBasedDay == null || sundayBasedDay is! int){
    return 1;
  }
  return ((sundayBasedDay + 6) % 7) + 1;
}