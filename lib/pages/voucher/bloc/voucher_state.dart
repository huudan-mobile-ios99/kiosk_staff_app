part of 'voucher_bloc.dart';


enum VoucherStatus { initial, success, failure,noinput }


 class VoucherState extends Equatable{
const VoucherState({
    this.status = VoucherStatus.initial,
    this.vouchers = const <Voucher>[],
    this.vouchersAvailable = const <Voucher>[],
    this.vouchersRedeemed = const <Voucher>[],
    this.vouchersExpired = const <Voucher>[],
    this.input = '',
  });

  final VoucherStatus status;
  final List<Voucher> vouchers;
  final List<Voucher> vouchersAvailable;
  final List<Voucher> vouchersRedeemed;
  final List<Voucher> vouchersExpired;
  final String input; // Add input field to store the input value


  VoucherState copyWith({
    VoucherStatus? status,
    List<Voucher>? vouchers,
    List<Voucher>? vouchersAvailable,
    List<Voucher>? vouchersRedeemed,
    List<Voucher>? vouchersExpired,
    String? input,
  }) {
    return VoucherState(
      status: status ?? this.status,
      vouchers: vouchers ?? this.vouchers,
      vouchersAvailable: vouchersAvailable ?? this.vouchersAvailable,
      vouchersRedeemed: vouchersRedeemed ?? this.vouchersRedeemed,
      vouchersExpired: vouchersExpired ?? this.vouchersExpired,
      input: input ?? this.input,
    );
  }

  @override
  String toString() {
    return 'VoucherState { status: $status, vouchers: ${vouchers.length} }';
  }

  @override
  List<Object> get props => [status, vouchers,vouchersAvailable,vouchersRedeemed,vouchersExpired,input];

}


