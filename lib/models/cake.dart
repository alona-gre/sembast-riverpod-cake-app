// ignore_for_file: public_member_api_docs, sort_constructors_first

class Cake {
  final int? id;
  final String? name;
  final int? yummyness;

  Cake({this.id, this.name, this.yummyness});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'yummyness': yummyness,
    };
  }

  Cake copyWith({int? id, String? name, int? yummyness}) {
    return Cake(
      id: id ?? this.id,
      name: name ?? this.name,
      yummyness: yummyness ?? this.yummyness,
    );
  }

  factory Cake.fromMap(Map<String, dynamic> map) {
    return Cake(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      yummyness: map['yummyness'] != null ? map['yummyness'] as int : null,
    );
  }

// String toJson() => json.encode(toMap())
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'yummyness': yummyness,
      };

  // factory Cake.fromJson(String source) =>
  //     Cake.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Cake.fromJson(Map<String, dynamic> json) => Cake(
        id: json['id'] as int? ?? -1,
        name: json['name'] as String,
        yummyness: json['yummyness'] as int,
      );
}
