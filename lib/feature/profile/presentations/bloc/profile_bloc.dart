import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/feature/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:navigation_2/feature/auth/domain/usecases/update_user_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;

  ProfileBloc({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
  }) : super(ProfileInitial()) {
    on<FetchUserProfile>(_onFetchUserProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onFetchUserProfile(
    FetchUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await getUserProfileUseCase(event.uid);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await updateUserProfileUseCase(event.user);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => add(FetchUserProfile(event.user.id)),
    );
  }
}
