class Comment {
  const Comment(
      {required this.comment, required this.rating, required this.owner});

  final String comment;
  final String owner;
  final double rating;

  Comment copyWith({
    String? comment,
    double? rating,
    String? owner,
  }) =>
      Comment(
        comment: comment ?? this.comment,
        rating: rating ?? this.rating,
        owner: owner ?? this.owner,
      );

  factory Comment.fromJson(Map<dynamic, dynamic> json) {
    return Comment(
        comment: json['comment'], rating: json['rating'], owner: json['owner']);
  }

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'rating': rating,
        'owner': owner,
      };

  List<Object> get props => [comment, rating, owner];
}
