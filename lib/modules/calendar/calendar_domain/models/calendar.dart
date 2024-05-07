class Calendar {
  const Calendar({
    required this.uuid,
    required this.color,
    this.description,
    required this.name,
  });

  final String uuid;
  final String color;
  final String? description;
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Calendar &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid &&
          color == other.color &&
          description == other.description &&
          name == other.name);

  @override
  int get hashCode =>
      uuid.hashCode ^ color.hashCode ^ description.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Calendar{' +
        ' uuid: $uuid,' +
        ' color: $color,' +
        ' description: $description,' +
        ' name: $name,' +
        '}';
  }

  Calendar copyWith({
    String? uuid,
    String? color,
    String? Function()? description,
    String? name,
  }) {
    return Calendar(
      uuid: uuid ?? this.uuid,
      color: color ?? this.color,
      description: description  == null ? this.description : description(),
      name: name ?? this.name,
    );
  }
}
