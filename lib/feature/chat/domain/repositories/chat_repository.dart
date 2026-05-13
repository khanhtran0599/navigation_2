import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(MessageEntity message);
  Stream<List<MessageEntity>> getMessages(String senderId, String receiverId);
}
