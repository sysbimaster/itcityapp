import 'package:equatable/equatable.dart';
import 'package:itcity_online_store/api/models/models.dart';

abstract class UserState extends Equatable{}

class UserInitial extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserRegistrationLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserRegistrationSuccessState extends UserState {
  final CustomerRegistration? customerRegistration;
  UserRegistrationSuccessState({this.customerRegistration});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserRegistrationErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SellAccountCreationLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SellAccountCreationSuccessState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SellAccountCreationErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RemoveUserAccountLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RemoveUserAccountSuccessState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RemoveUserAccountErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignUpNewsLetterLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignUpNewsLetterSuccessState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignUpNewsLetterErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OtpVerificationLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OtpVerificationSuccessState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OtpVerificationErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ForgotPasswordLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ForgotPasswordLoadedState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ForgotPasswordErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CustomerLoginLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CustomerLoginSuccessState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CustomerLoginErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CheckMobileNumberStatusLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CheckMobileNumberStatusLoadedState extends UserState {
   bool numberUsed;
  CheckMobileNumberStatusLoadedState(this.numberUsed);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CheckMobileNumberStatusErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CheckEmailSubScriptionLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CheckEmailSubScriptionLoadedState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CheckEmailSubScriptionErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CheckEmailStatusLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class CustomerLoginFailedState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}


class CheckEmailStatusLoadedState extends UserState {
  bool? emailUsed;
  CheckEmailStatusLoadedState(this.emailUsed);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CheckEmailStatusErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CustomerInformationLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CustomerInformationLoadedState extends UserState {
  final CustomerRegistration customerlist;
  CustomerInformationLoadedState({required this.customerlist});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CustomerInformationUpdatedState extends CustomerInformationLoadedState{
   final CustomerRegistration customerlist;
  CustomerInformationUpdatedState({required this.customerlist}):
        super(customerlist:customerlist);
        
}

class CustomerInformationErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
