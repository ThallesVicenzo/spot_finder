import 'package:flutter/material.dart';

import 'comment.dart';

class TouristSpot {
  const TouristSpot({
    required this.title,
    required this.location,
    required this.owner,
    required this.id,
    this.description,
    this.comments,
    this.category,
    this.pinColor,
    this.rating,
    this.mainPicture,
    this.isFavorite,
  });

  final String title;
  final String location;
  final String owner;
  final String? mainPicture;
  final String? category;
  final String? description;
  final List<Comment>? comments;
  final String id;
  final Color? pinColor;
  final double? rating;
  final bool? isFavorite;

  TouristSpot copyWith({
    String? title,
    String? location,
    String? mainPicture,
    String? owner,
    String? category,
    String? description,
    String? id,
    List<Comment>? comments,
    Color? pinColor,
    double? rating,
    bool? isFavorite,
  }) {
    return TouristSpot(
      title: title ?? this.title,
      location: location ?? this.location,
      owner: owner ?? this.owner,
      mainPicture: mainPicture ?? this.mainPicture,
      description: description ?? this.description,
      comments: comments ?? this.comments,
      id: id ?? this.id,
      category: category ?? this.category,
      pinColor: pinColor ?? this.pinColor,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory TouristSpot.fromJson(Map<String, dynamic> json) {
    List<Comment> comments = [];

    if (json['comments'] != null) {
      var list = List.from(json['comments']);
      list.map((e) => comments.add(Comment.fromJson(e)));
    }

    return TouristSpot(
      title: json['title'],
      location: json['location'],
      owner: json['owner'],
      description: json['description'],
      id: json['id'],
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
        'owner': owner,
        'id': id,
        'comments': comments,
        'description': description,
        'pinColor': pinColor,
        'rating': rating,
        'mainPicture': mainPicture,
        'isFavorite': isFavorite,
      };

  List<dynamic> get props => [
        title,
        location,
        mainPicture,
        category,
        owner,
        description,
        comments,
        id,
        pinColor,
        rating,
        isFavorite,
      ];
}
