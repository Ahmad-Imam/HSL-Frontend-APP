class StationList {
  StationList({
    required this.finalStationList,
  });
  late final List<FinalStationList> finalStationList;

  StationList.fromJson(Map<String, dynamic> json) {
    finalStationList = List.from(json['finalStationList'])
        .map((e) => FinalStationList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['finalStationList'] =
        finalStationList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class FinalStationList {
  FinalStationList({
    required this.ID,
    required this.Nimi,
    required this.Namn,
    required this.Name,
    required this.Osoite,
    required this.Adress,
    required this.Kaupunki,
    required this.Stad,
    required this.Operaattor,
    required this.Kapasiteet,
    required this.x,
    required this.y,
  });

  late final String ID;
  late final String Nimi;
  late final String Namn;
  late final String Name;
  late final String Osoite;
  late final String Adress;
  late final String Kaupunki;
  late final String Stad;
  late final String Operaattor;
  late final String Kapasiteet;
  late final String x;
  late final String y;

  FinalStationList.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    Nimi = json['Nimi'];
    Namn = json['Namn'];
    Name = json['Name'];
    Osoite = json['Osoite'];
    Adress = json['Adress'];
    Kaupunki = json['Kaupunki'];
    Stad = json['Stad'];
    Operaattor = json['Operaattor'];
    Kapasiteet = json['Kapasiteet'];
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['ID'] = ID;
    _data['Nimi'] = Nimi;
    _data['Namn'] = Namn;
    _data['Name'] = Name;
    _data['Osoite'] = Osoite;
    _data['Adress'] = Adress;
    _data['Kaupunki'] = Kaupunki;
    _data['Stad'] = Stad;
    _data['Operaattor'] = Operaattor;
    _data['Kapasiteet'] = Kapasiteet;
    _data['x'] = x;
    _data['y'] = y;
    return _data;
  }
}
