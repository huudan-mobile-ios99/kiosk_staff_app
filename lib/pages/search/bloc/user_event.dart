part of 'user_bloc.dart';

 class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersRefreshed extends UserEvent {}

class UsersCleared extends UserEvent {}



 class UsersFetched extends UserEvent {
  final String searchKeyword;

  UsersFetched(this.searchKeyword);

  @override
  List<Object> get props => [searchKeyword];
 }



// New event for fetching and filtering users
class UsersFetchedFiltered extends UserEvent {
  final String filter;
  UsersFetchedFiltered(this.filter);
  @override
  List<Object> get props => [filter];
}

// Events
class SearchCustomerEvent extends UserEvent {
  final String keyword;

  SearchCustomerEvent(this.keyword);
}



// New event for fetching and filtering customers
class CustomerSearchFiltered extends UserEvent {
  final String filter;
  CustomerSearchFiltered(this.filter);
  @override
  List<Object> get props => [filter];
}