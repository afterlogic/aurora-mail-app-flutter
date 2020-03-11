class AlwaysNonEqualObject {
  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;
}
