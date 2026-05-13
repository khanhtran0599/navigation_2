import 'package:navigation_2/feature/chat/domain/entities/message_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase({required this.repository});

  Stream<List<MessageEntity>> call(String senderId, String receiverId) {
    return repository.getMessages(senderId, receiverId);
  }
}
