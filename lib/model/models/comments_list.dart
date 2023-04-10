import 'comment.dart';

class CommentList {
  const CommentList({required this.comments});

  final List<Comment> comments;

  factory CommentList.fromJson(List<dynamic> json) {
    List<Comment> comments = json.map((e) => Comment.fromJson(e)).toList();
    return CommentList(comments: comments);
  }

  Map<String, dynamic> toJson() => {'comments': comments};

  List<Object> get props => [comments];
}
