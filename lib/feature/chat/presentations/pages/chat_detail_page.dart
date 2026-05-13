import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:navigation_2/core/di/service_locator.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_bloc.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_state.dart';
import 'package:navigation_2/feature/chat/domain/entities/message_entity.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/usecases/get_messages_usecase.dart';
import 'package:navigation_2/feature/chat/domain/usecases/send_message_usecase.dart';
import 'package:navigation_2/feature/chat/domain/usecases/upload_image_usecase.dart';

class ChatDetailPage extends StatefulWidget {
  final UserEntity targetUser;

  const ChatDetailPage({super.key, required this.targetUser});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String senderId, {String? imageUrl}) {
    if (_messageController.text.trim().isEmpty && imageUrl == null) return;

    final message = MessageEntity(
      id: '',
      senderId: senderId,
      receiverId: widget.targetUser.id.toString(),
      message: _messageController.text.trim(),
      imageUrl: imageUrl,
      timestamp: DateTime.now(),
    );

    sl<SendMessageUseCase>().call(message);
    _messageController.clear();
  }

  Future<void> _pickAndSendImage(String senderId) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;

    setState(() {
      _isUploading = true;
    });

    final result = await sl<UploadImageUseCase>().call(File(image.path), senderId);

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload failed: ${failure.message}")),
        );
      },
      (imageUrl) {
        _sendMessage(senderId, imageUrl: imageUrl);
      },
    );

    setState(() {
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      return const Scaffold(body: Center(child: Text("Please login to chat")));
    }

    final currentUserId = authState.user.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.targetUser.name),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.base,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageEntity>>(
              stream: sl<GetMessagesUseCase>().call(currentUserId, widget.targetUser.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No messages yet. Say hi!"));
                }

                final messages = snapshot.data!;

                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.senderId == currentUserId;
                    final timeStr = DateFormat('HH:mm').format(msg.timestamp);

                    return Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: isMe ? AppColors.primary : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20).copyWith(
                                bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(20),
                                bottomLeft: isMe ? const Radius.circular(20) : const Radius.circular(0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (msg.imageUrl != null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        msg.imageUrl!,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return const SizedBox(
                                            width: 200,
                                            height: 200,
                                            child: Center(child: CircularProgressIndicator()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                if (msg.message.isNotEmpty)
                                  Text(
                                    msg.message,
                                    style: TextStyle(
                                      color: isMe ? Colors.white : Colors.black87,
                                      fontSize: 16,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Text(
                            timeStr,
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          if (_isUploading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          _buildMessageInput(currentUserId),
        ],
      ),
    );
  }

  Widget _buildMessageInput(String currentUserId) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon:  Icon(Icons.image, color: AppColors.primary),
            onPressed: () => _pickAndSendImage(currentUserId),
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _sendMessage(currentUserId),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration:  BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
