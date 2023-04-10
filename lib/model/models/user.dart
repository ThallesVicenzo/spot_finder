class User {
  const User(
      {required this.displayName,
      required this.email,
      required this.photoUrl,
      required this.uid});

  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;

  User copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? photoUrl,
  }) {
    return User(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory User.fromJson({required Map<String, dynamic> json}) {
    return User(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
      };

  List<Object> get props => [displayName, email, photoUrl, uid];
}
