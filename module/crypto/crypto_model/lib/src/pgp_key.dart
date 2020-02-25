class PgpKey {
  final String name;
  final String mail;
  final String key;
  final bool isPrivate;
  final int length;

  PgpKey({
    this.name,
    this.mail,
    this.isPrivate,
    this.key,
    this.length,
  });

  PgpKey.fill(
    this.name,
    this.mail,
    this.isPrivate,
    this.key,
    this.length,
  );
}
