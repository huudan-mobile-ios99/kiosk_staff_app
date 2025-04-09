part of 'user_bloc.dart';


enum UserStatus { initial, success, failure }

class UserState extends Equatable {
  final UserStatus status;
  final CustomerList users;

  const UserState({
    this.status = UserStatus.initial,
    this.users = const CustomerList(list: []),  // Use 'const' for default values
  });

  UserState copyWith({
    UserStatus? status,
    CustomerList? users,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }

  @override
  String toString() {
    return 'UserState {status: $status, users: ${users.list.length}}';
  }

  @override
  List<Object> get props => [status, users];
}