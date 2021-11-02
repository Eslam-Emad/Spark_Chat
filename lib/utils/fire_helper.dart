class FireHelper {
  FireHelper._();

  static final _instance = FireHelper._();

  factory FireHelper() => _instance;

  static String generateRoomId(String firstUserId, String secondUserId) =>
      firstUserId.hashCode > secondUserId.hashCode
          ? "$firstUserId - $secondUserId"
          : "$secondUserId - $firstUserId";
}
