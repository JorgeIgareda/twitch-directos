class Channel {
  String id;
  String userId;
  String userLogin;
  String userName;
  String gameId;
  String gameName;
  String title;

  Channel(
      {required this.id,
      required this.userId,
      required this.userLogin,
      required this.userName,
      required this.gameId,
      required this.gameName,
      required this.title});

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        userLogin: json['user_login'] as String,
        userName: json['user_name'] as String,
        gameId: json['game_id'] as String,
        gameName: json['game_name'] as String,
        title: json['title'] as String);
  }
}
