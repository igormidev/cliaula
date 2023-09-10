import 'package:cliaula/core/exceptions/custom_exception.dart';
import 'package:cliaula/infra/entities/comment_entity.dart';
import 'package:cliaula/infra/interfaces/api_source.dart';
import 'package:dartz/dartz.dart';

class CommentsUsecase {
  final IApiSource source;
  const CommentsUsecase(this.source);

  AsyncResp<List<CommentEntity>> getComents() async {
    return await source.getList(
      url: '/comments/',
      fromMapFunc: CommentEntity.fromMap,
    );
  }
}
