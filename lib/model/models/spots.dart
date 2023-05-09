import 'comment.dart';

class TouristSpotModel {
  const TouristSpotModel({
    required this.title,
    required this.location,
    required this.description,
    required this.category,
    required this.mainPicture,
    required this.pinColor,
    this.comments,
    this.rating,
    this.isFavorite,
  });

  final String title;
  final String location;
  final String? mainPicture;
  final String? category;
  final String? description;
  final List<Comment>? comments;
  final String? pinColor;
  final double? rating;
  final bool? isFavorite;

  TouristSpotModel copyWith({
    String? title,
    String? location,
    String? mainPicture,
    String? category,
    String? description,
    List<Comment>? comments,
    String? pinColor,
    double? rating,
    bool? isFavorite,
  }) {
    return TouristSpotModel(
      title: title ?? this.title,
      location: location ?? this.location,
      mainPicture: mainPicture ?? this.mainPicture,
      description: description ?? this.description,
      comments: comments ?? this.comments,
      category: category ?? this.category,
      pinColor: pinColor ?? this.pinColor,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory TouristSpotModel.fromJson(Map<String, dynamic> json) {
    List<Comment> comments = [];

    if (json['comments'] != null) {
      var list = List.from(json['comments']);
      list.map((e) => comments.add(Comment.fromJson(e)));
    }

    return TouristSpotModel(
      title: json['title'],
      location: json['location'],
      description: json['description'],
      comments: comments,
      category: json['category'],
      pinColor: json['pinColor'],
      rating: json['rating'],
      mainPicture: json['mainPicture'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'location': location,
        'category': category,
        'comments': comments,
        'description': description,
        'pinColor': pinColor,
        'rating': rating,
        'mainPicture': mainPicture,
        'isFavorite': isFavorite,
      };
}
