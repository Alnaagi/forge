class UuidService {
  const UuidService();

  String next() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}
