import 'package:equatable/equatable.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends ProfileEvent {
  final String uid;

  const FetchUserProfile(this.uid);

  @override
  List<Object> get props => [uid];
}

class UpdateProfile extends ProfileEvent {
  final UserEntity user;

  const UpdateProfile(this.user);

  @override
  List<Object> get props => [user];
}
