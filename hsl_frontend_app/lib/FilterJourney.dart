class FilterJourney {
  FilterJourney({
    required this.totalReturn,
    required this.totalDeparture,
    required this.avgReturn,
    required this.avgDeparture,
  });
  late final int totalReturn;
  late final int totalDeparture;
  late final String avgReturn;
  late final String avgDeparture;

  FilterJourney.fromJson(Map<String, dynamic> json) {
    totalReturn = json['totalReturn'];
    totalDeparture = json['totalDeparture'];
    avgReturn = json['avgReturn'].toString();
    avgDeparture = json['avgDeparture'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['totalReturn'] = totalReturn;
    _data['totalDeparture'] = totalDeparture;
    _data['avgReturn'] = avgReturn;
    _data['avgDeparture'] = avgDeparture;
    return _data;
  }
}
