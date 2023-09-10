import 'package:cliaula/core/exceptions/custom_exception.dart';
import 'package:cliaula/infra/entities/post_entity.dart';
import 'package:cliaula/infra/interfaces/api_source.dart';
import 'package:dartz/dartz.dart';

class PostUsecase {
  final IApiSource source;
  const PostUsecase(this.source);

  AsyncResp<PostEntity> getPostWithId(int id) async {
    return await source.get<PostEntity>(
      url: '/posts/$id',
      fromMapFunc: PostEntity.fromMap,
    );
  }

  AsyncResp<List<PostEntity>> getAllPosts() async {
    return await source.getList(
      url: '/posts/',
      fromMapFunc: PostEntity.fromMap,
    );
  }

  AsyncResp<void> postPost(PostEntity post) async {
    await source.post(
      url: '/posts',
      payload: post.toMap(),
    );

    return right(null);
  }

  AsyncResp<void> updatePost(int id, PostEntity newPost) async {
    await source.put(
      url: '/posts/$id',
      payload: newPost.toMap(),
    );

    return right(null);
  }

  AsyncResp<void> deletePost(int id) async {
    await source.delete(
      url: '/posts/$id',
    );

    return right(null);
  }
}
