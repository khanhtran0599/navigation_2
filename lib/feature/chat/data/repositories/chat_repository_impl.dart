import 'package:navigation_2/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:navigation_2/feature/chat/data/data_source/chat_remote_data_source.dart';
import 'package:navigation_2/feature/chat/data/model/message_model.dart';
import 'package:navigation_2/feature/chat/domain/entities/message_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> sendMessage(MessageEntity message) async {
    try {
      await remoteDataSource.sendMessage(MessageModel.fromEntity(message));
      return const Right(null);
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(String senderId, String receiverId) {
    return remoteDataSource.getMessages(senderId, receiverId);
  }
}
