import 'dart:async';

import 'package:itcity_online_store/blocs/user/user.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  UserApi userApi;
  bool? userStatus;
  SellOnItcity? accountToSale;
  String? otpValue;
  bool? emailStatus;
  String? mobileStatus;
  String? token;
  CustomerRegistration? customer;
  ApiResponse? response;
  UserBloc(this.userApi) : super(UserInitial()){
    on<UserLogoutEvent>((event, emit) => _logoutEventtoState(event, emit));
    on<UserRegistrationEvent>((event, emit) => _mapUserRegistrationToState(event,emit,event.user));
    on<RemoveUserAccountEvent>((event, emit) => _mapRemoveUserAccountToState(event,emit,event.customerId));
    on<ForgotPasswordEvent>((event, emit) => _mapForgotPasswordToState(event,emit,event.email));
    on<FetchCustomerInformationEvent>((event, emit) => _mapFetchCustomerInformationToState(event,emit,event.customerEmail));
    on<UpdateCustomerEvent>((event, emit) => _mapFetchCustomerInformationUpdatedToState(event,emit,event.customerRegistration.customerEmail));
    on<CustomerLoginEvent>((event, emit) => _mapCustomerLoginToState(event, emit, event.customer));
    on<CheckEmailStatusEvent>((event, emit) => _mapCheckEmailStatusToState(event, emit, event.mail));
  }
  // @override
  // Stream<UserState> mapEventToState(
  //   UserEvent event,
  // ) async* {
  //   if (event is UserLogoutEvent) {
  //     yield UserInitial();
  //   }
  //   if (event is UserRegistrationEvent) {
  //    // yield* _mapUserRegistrationToState(event, state, event.user);
  //   }
  //   // if (event is CreateAccountToSellOnItCityEvent) {
  //   //   yield* _mapCreateAccountToSellOnItCityToState(
  //   //       event, state, event.sellAccount);
  //   // }
  //   if (event is RemoveUserAccountEvent) {
  //   //  yield* _mapRemoveUserAccountToState(event, state, event.customerId);
  //   }
  //   // if (event is SignupForNewsLetterEvent) {
  //   //   yield* _mapSignupForNewsLetterToState(event, state, event.email);
  //   // }
  //   // if (event is OtpVerificationEvent) {
  //   //   yield* _mapOtpVerificationToState(event, state, event.otp);
  //   // }
  //   if (event is ForgotPasswordEvent) {
  //    // yield* _mapForgotPasswordToState(event, state, event.email);
  //   }
  //   if (event is CustomerLoginEvent) {
  //    // yield* _mapCustomerLoginToState(event, state, event.customer);
  //   }
  //   if (event is CheckMobileNumberStatusEvent) {
  //    // yield* _mapCheckMobileNumberStatusToState(event, state, event.mobile);
  //   }
  //   if (event is CheckEmailSubScriptionEvent) {
  //     //yield* _mapCheckEmailSubScriptionToState(event, state, event.email);
  //   }
  //   if (event is CheckEmailStatusEvent) {
  //
  //   //  yield* _mapCheckEmailStatusToState(event, state, event.mail);
  //   }
  //   if (event is FetchCustomerInformationEvent) {
  //     // yield* _mapFetchCustomerInformationToState(
  //     //     event, state, event.customerEmail);
  //   }
  //   if (event is UpdateCustomerEvent) {
  //     // yield* _mapFetchCustomerInformationUpdatedToState(
  //     //     event, state, event.customerRegistration.customerEmail);
  //   }
  // }
void _logoutEventtoState(UserEvent event,Emitter<UserState> emit){
    emit(UserInitial());
}

void _mapUserRegistrationToState(
      UserEvent event, Emitter<UserState> emit, CustomerRegistration user) async {
    emit( UserRegistrationLoadingState());
    try {
      final CustomerRegistration customerRegistration = await userApi.registerUser(user);
      print("yielded userregistration");
      emit(UserRegistrationSuccessState(customerRegistration: customerRegistration));

      //Emit a event to check email
    } catch (e) {}
  }

  Stream<UserState> _mapCreateAccountToSellOnItCityToState(
      UserEvent event, UserState state, SellOnItcity sellAccount) async* {
    try {
      final SellOnItcity account =
          await userApi.accountCreationToSellOnItCity(sellAccount);
      accountToSale = account;
    } catch (e) {}
  }

  void _mapRemoveUserAccountToState(
      UserEvent event, Emitter<UserState> emit, var customerId) async {
    try {
      final String? isRemoved = await userApi.removeUserAccount(customerId);
    } catch (e) {}
  }

  // To do: later
  Stream<UserState> _mapSignupForNewsLetterToState(
      UserEvent event, UserState state, var email) async* {
    try {
      final String? isRegistered = await userApi.signUpForNewsLetter(email);
    } catch (e) {}
  }

  Stream<UserState> _mapOtpVerificationToState(
      UserEvent event, UserState state, var otp) async* {
    try {
      final String? isVerified = await userApi.otpVerification(otp);
    } catch (e) {}
  }

void _mapForgotPasswordToState(
      UserEvent event,  Emitter<UserState> emit, var email) async {
    try {
      final String? otp = await userApi.forgotPassword(email);
      otpValue = otp;
    } catch (e) {}
  }

void _mapCustomerLoginToState(
      UserEvent event,  Emitter<UserState> emit, CustomerRegistration customer) async {
    emit( CustomerLoginLoadingState());
    try {
      String? tokenValue = await userApi.customerLogin(customer);
      print(tokenValue);
      this.token = tokenValue;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', customer.customerEmail!);
      await prefs.setString('token', this.token!);



        emit(CustomerLoginSuccessState());
    } catch (e) {
      print('userbloc'+e.toString());
      emit(CustomerLoginErrorState());
    }
  }

  Stream<UserState> _mapCheckMobileNumberStatusToState(
      UserEvent event, UserState state, var mobile) async* {
    yield CheckMobileNumberStatusLoadingState();
    try {
      final String? status = await userApi.checkMobileNumberStatus(mobile);
      mobileStatus = status;
      yield CheckMobileNumberStatusLoadedState(true);
    } catch (e) {
      print(e);
    }
  }

  // To do: later
  Stream<UserState> _mapCheckEmailSubScriptionToState(
      UserEvent event, UserState state, var email) async* {
    try {
      final String? isSubscribed = await userApi.checkEmailSubScription(email);
    } catch (e) {}
  }

  void _mapCheckEmailStatusToState(
      UserEvent event,Emitter<UserState> emit, String mail) async {
       
    emit(CheckEmailStatusLoadingState());
    try {
      final bool status = await userApi.checkEmailStatus(mail);
      emailStatus = status;
      print("Email Status is" + emailStatus.toString());
      emit(CheckEmailStatusLoadedState(emailStatus));
    } catch (e) {
      print(e);
    }
  }

 void _mapFetchCustomerInformationToState(
      UserEvent event, Emitter<UserState> emit, String? mail) async {
    emit( CustomerInformationLoadingState());
    try {
      final CustomerRegistration info =
          await userApi.fetchCustomerInformation(mail);
      customer = info;
      //final storage = new FlutterSecureStorage();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('customerId', customer!.customerId.toString());

      emit( CustomerInformationLoadedState(customerlist: info));
    } catch (e) {
      print('error in fetching user information>>>>>> ' + e.toString());
    }
  }

 void _mapFetchCustomerInformationUpdatedToState(
      UpdateCustomerEvent event,Emitter<UserState> emit, String? mail) async {
    emit(CustomerInformationLoadingState());
    try {
      await userApi.updateUser(event.customerRegistration);
      final CustomerRegistration info = await userApi
          .fetchCustomerInformation(event.customerRegistration.customerEmail);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('customerId', customer!.customerId.toString());

      emit( CustomerInformationUpdatedState(customerlist: info));
    } catch (e) {
      print('error in fetching user information>>>>>> ' + e.toString());
    }
  }
}
