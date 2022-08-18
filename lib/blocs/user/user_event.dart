
import 'package:equatable/equatable.dart';
import 'package:itcity_online_store/api/models/models.dart';

abstract class UserEvent extends Equatable {}
 
class UserLogoutEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class UserRegistrationEvent extends UserEvent {
  final CustomerRegistration user;
  UserRegistrationEvent(this.user);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CreateAccountToSellOnItCityEvent extends UserEvent {
  final SellOnItcity sellAccount;
  CreateAccountToSellOnItCityEvent(this.sellAccount);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RemoveUserAccountEvent extends UserEvent {
  final int customerId;
  RemoveUserAccountEvent(this.customerId);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignupForNewsLetterEvent extends UserEvent {
  final String email;
  SignupForNewsLetterEvent(this.email);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OtpVerificationEvent extends UserEvent {
  final String otp;
  OtpVerificationEvent(this.otp);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ForgotPasswordEvent extends UserEvent {
  final String email;
  ForgotPasswordEvent(this.email);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class CustomerLoginEvent extends UserEvent{
   @override
  List<Object> get props => [];
  final CustomerRegistration customer;
  CustomerLoginEvent(this.customer);
}
class CheckMobileNumberStatusEvent extends UserEvent{
  final String mobile;
  CheckMobileNumberStatusEvent(this.mobile);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class CheckEmailSubScriptionEvent extends UserEvent{
  final String email;
  CheckEmailSubScriptionEvent(this.email);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class CheckEmailStatusEvent extends UserEvent{
  final String mail;
  CheckEmailStatusEvent(this.mail);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class FetchCustomerInformationEvent extends UserEvent{
  final String? customerEmail;
  FetchCustomerInformationEvent(this.customerEmail);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UpdateCustomerEvent extends UserEvent{
  final CustomerRegistration customerRegistration;
  UpdateCustomerEvent(this.customerRegistration);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}