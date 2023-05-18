class AutoGenerateJourney {
  AutoGenerateJourney({
    required this.finalJourneyList,
  });
  late final List<FinalJourneyList> finalJourneyList;

  AutoGenerateJourney.fromJson(Map<String, dynamic> json) {
    finalJourneyList = List.from(json['finalJourneyList'])
        .map((e) => FinalJourneyList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['finalJourneyList'] =
        finalJourneyList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class FinalJourneyList {
  FinalJourneyList({
    required this.departureDate,
    required this.returnDate,
    required this.departureStationId,
    required this.departureStationName,
    required this.returnStationId,
    required this.returnStationName,
    required this.coverDistance,
    required this.duration,
  });
  late final String departureDate;
  late final String returnDate;
  late final String departureStationId;
  late final String departureStationName;
  late final String returnStationId;
  late final String returnStationName;
  late final String coverDistance;
  late final String duration;

  FinalJourneyList.fromJson(Map<String, dynamic> json) {
    departureDate = json['departureDate'];
    returnDate = json['returnDate'];
    departureStationId = json['departureStationId'];
    departureStationName = json['departureStationName'];
    returnStationId = json['returnStationId'];
    returnStationName = json['returnStationName'];
    coverDistance = json['coverDistance'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['departureDate'] = departureDate;
    _data['returnDate'] = returnDate;
    _data['departureStationId'] = departureStationId;
    _data['departureStationName'] = departureStationName;
    _data['returnStationId'] = returnStationId;
    _data['returnStationName'] = returnStationName;
    _data['coverDistance'] = coverDistance;
    _data['duration'] = duration;
    return _data;
  }
}
