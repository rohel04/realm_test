part of 'my_profile_cubit.dart';

class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object> get props => [];
}

class MyProfileInitial extends MyProfileState {}

class MyProfileLoaded extends MyProfileState {
  final CustomeUser user;

  const MyProfileLoaded({required this.user});
  @override
  List<Object> get props => [user];
}
