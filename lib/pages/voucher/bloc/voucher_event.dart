part of 'voucher_bloc.dart';



 class VoucherEvent extends Equatable {
  @override
  List<Object?> get props => []; 
  
}

 class VoucherFetched extends VoucherEvent{
    final String input;

  VoucherFetched(this.input);

  @override
  List<Object> get props => [input];
 }
 class VoucherRefreshed extends VoucherEvent{}