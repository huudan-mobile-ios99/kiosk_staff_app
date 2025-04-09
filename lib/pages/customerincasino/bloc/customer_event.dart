part of 'customer_bloc.dart';

 class CustomerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

 class CustomerFetched extends CustomerEvent {}
class CustomerRefreshed extends CustomerEvent {}

class CustomerCleared extends CustomerEvent {}



// New event for fetching and filtering customers
class CustomerFetchedFiltered extends CustomerEvent {
  final String filter;
  CustomerFetchedFiltered(this.filter);
  @override
  List<Object> get props => [filter];
}




// New event for fetching and filtering customers
class CustomerSearchFiltered extends CustomerEvent {
  final String filter;
  CustomerSearchFiltered(this.filter);
  @override
  List<Object> get props => [filter];
}