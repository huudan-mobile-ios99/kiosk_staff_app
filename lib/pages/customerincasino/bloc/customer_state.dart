part of 'customer_bloc.dart';

enum CustomerStatus { initial, success, failure }

class CustomerState extends Equatable {
  final CustomerStatus status;
  final List<CustomerData> customers;
  final List<CustomerData> customersFiltered;
  final List<CustomerData> customersSortNumberDesc;
  final List<CustomerData> customersSortNumberAsc;
  final List<CustomerData> customersP;
  final List<CustomerData> customersI;
  final List<CustomerData> customersV;
  final List<CustomerData> customersONE;
  final List<CustomerData> customersONEPLUS;
  final List<CustomerData> customersSearch;
  final String total;
  const CustomerState({
    this.status = CustomerStatus.initial,
    this.customers = const <CustomerData>[],
    this.customersFiltered = const <CustomerData>[],
    this.customersSortNumberDesc = const <CustomerData>[],
    this.customersSortNumberAsc = const <CustomerData>[],
    this.customersP = const <CustomerData>[],
    this.customersI = const <CustomerData>[],
    this.customersV = const <CustomerData>[],
    this.customersONE = const <CustomerData>[],
    this.customersONEPLUS = const <CustomerData>[],
    this.customersSearch = const <CustomerData>[],
    this.total = '',
  });

  CustomerState copyWith({
    CustomerStatus? status,
    List<CustomerData>? customers,
    List<CustomerData>? customersFiltered,
    List<CustomerData>? customersSortNumberDesc,
    List<CustomerData>? customersSortNumberAsc,
    List<CustomerData>? customersP,
    List<CustomerData>? customersI,
    List<CustomerData>? customersV,
    List<CustomerData>? customersONE,
    List<CustomerData>? customersONEPLUS,
    List<CustomerData>? customersSearch,
    String? total,
  }) {
    return CustomerState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      customersFiltered: customersFiltered ?? this.customersFiltered,
      customersSortNumberDesc:
          customersSortNumberDesc ?? this.customersSortNumberDesc,
      customersSortNumberAsc:
          customersSortNumberAsc ?? this.customersSortNumberAsc,
      customersP: customersP ?? this.customersP,
      customersI: customersI ?? this.customersI,
      customersV: customersV ?? this.customersV,
      customersONE: customersONE ?? this.customersONE,
      customersONEPLUS: customersONEPLUS ?? this.customersONEPLUS,
      total: total ?? this.total,
      customersSearch: customersSearch ?? this.customersSearch,
    );
  }

  //toString
  @override
  String toString() {
    return 'CustomerState {status: $status, customers: ${customers.length}';
  }

  //props
  @override
  List<Object> get props => [
        status,
        customers,
        customersFiltered,
        customersSortNumberDesc,
        customersSortNumberAsc,
        customersP,
        customersI,
        customersV,
        customersONE,
        customersONEPLUS,
        customersSearch,
      ];
}
