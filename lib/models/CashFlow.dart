class CashFlow {
  String? keterangan;
  int? id;
  String? nominal;
  String? date;
  int? type;

  CashFlow({this.nominal, this.id, this.keterangan, this.date, this.type});

  factory CashFlow.fromJson(Map<String, dynamic> json) {
    return CashFlow(
      keterangan: json['keterangan'],
      id: json['id'],
      nominal: json['nominal'],
      date: json['date'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keterangan'] = this.keterangan;
    data['id'] = this.id;
    data['nominal'] = this.nominal;
    data['date'] = this.date;
    data['type'] = this.type;
    return data;
  }
}
