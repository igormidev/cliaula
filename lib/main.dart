import 'package:cliaula/core/exceptions/custom_exception.dart';
import 'package:cliaula/data/usecases/comments_usecase.dart';
import 'package:cliaula/data/usecases/post_usecase.dart';
import 'package:cliaula/infra/entities/post_entity.dart';
import 'package:cliaula/infra/implementations/dio_api_source_impl.dart';
import 'package:cliaula/infra/interfaces/api_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Future<void> main() async {
  // final IApiSource apiSource = HttpApiSourceImpl();
  final IApiSource apiSource = DioApiSourceImpl(Dio())..makeInitialConfigs();

  final getUsecase = PostUsecase(apiSource);
  final commentUsecase = CommentsUsecase(apiSource);

  final payloadFake = PostEntity(
    title: 'Igor',
    body: 'Body campo',
    id: 200,
    userId: 1,
  );

  final comments = await commentUsecase.getComents();

  final post = await getUsecase.getPostWithId(2);

  final posts = await getUsecase.getAllPosts();

  await getUsecase.postPost(payloadFake);

  final newPayload = payloadFake.copyWith(title: 'Marcelo');
  await getUsecase.updatePost(2, newPayload);

  await getUsecase.deletePost(2);

  final Either<Exception, int> response = tryCastString('48a');
  response.fold(
    (left) {
      print('CAIU NO LEFT $left');
    },
    (right) {
      print('CAIU NO RIGHT $right');
    },
  );
}

Either<Exception, int> tryCastString(String source) {
  try {
    return Right(int.parse(source));
  } catch (e) {
    return Left(Exception());
  }
}

Future<void> manegeDefaultResponse<T>(AsyncResp<T> response) async {
  (await response).fold(
    (left) {
      print('CAIU NO LEFT $left');
    },
    (right) {
      print('CAIU NO RIGHT $right');
    },
  );
}
