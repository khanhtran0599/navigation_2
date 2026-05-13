import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/domain/repositories/chat_repository.dart';

class UploadImageUseCase {
  final ChatRepository repository;

  UploadImageUseCase({required this.repository});

  Future<Either<Failure, String>> call(File file, String senderId) {
    return repository.uploadImage(file, senderId);
  }
}
