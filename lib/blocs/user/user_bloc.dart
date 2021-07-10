import 'dart:async';

import 'package:itcity_online_store/blocs/user/user.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.userApi) : super(UserInitial());
  UserApi userApi;
  bool userStatus;
  SellOnItcity accountToSale;
  String otpValue;
  bool emailStatus;
  String mobileStatus;
  String token;
  CustomerRegistration customer;
  ApiResponse response;

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLogoutEvent) {
      yield UserInitial();
    }
    if (event is UserRegistrationEvent) {
      yield* _mapUserRegistrationToState(event, state, event.user);
    }
    if (event is CreateAccountToSellOnItCityEvent) {
      yield* _mapCreateAccountToSellOnItCityToState(
          event, state, event.sellAccount);
    }
    if (event is RemoveUserAccountEvent) {
      yield* _mapRemoveUserAccountToState(event, state, event.customerId);
    }
    if (event is SignupForNewsLetterEvent) {
      yield* _mapSignupForNewsLetterToState(event, state, event.email);
    }
    if (event is OtpVerificationEvent) {
      yield* _mapOtpVerificationToState(event, state, event.otp);
    }
    if (event is ForgotPasswordEvent) {
      yield* _mapForgotPasswordToState(event, state, event.email);
    }
    if (event is CustomerLoginEvent) {
      yield* _mapCustomerLoginToState(event, state, event.customer);
    }
    if (event is CheckMobileNumberStatusEvent) {
      yield* _mapCheckMobileNumberStatusToState(event, state, event.mobile);
    }
    if (event is CheckEmailSubScriptionEvent) {
      yield* _mapCheckEmailSubScriptionToState(event, state, event.email);
    }
    if (event is CheckEmailStatusEvent) {
      
      yield* _mapCheckEmailStatusToState(event, state, event.mail);
    }
    if (event is FetchCustomerInformationEvent) {
      yield* _mapFetchCustomerInformationToState(
          event, state, event.customerEmail);
    }
    if (event is UpdateCustomerEvent) {
      yield* _mapFetchCustomerInformationUpdatedToState(
          event, state, event.customerRegistration.customerEmail);
    }
  }

  Stream<UserState> _mapUserRegistrationToState(
      UserEvent event, UserState state, CustomerRegistration user) async* {
    yield UserRegistrationLoadingState();
    try {
      final CustomerRegistration customerRegistration = await userApi.registerUser(user);
      print("yielded userregistration");
      yield UserRegistrationSuccessState(customerRegistration: customerRegistration);

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

  Stream<UserState> _mapRemoveUserAccountToState(
      UserEvent event, UserState state, var customerId) async* {
    try {
      final String isRemoved = await userApi.removeUserAccount(customerId);
    } catch (e) {}
  }

  // To do: later
  Stream<UserState> _mapSignupForNewsLetterToState(
      UserEvent event, UserState state, var email) async* {
    try {
      final String isRegistered = await userApi.signUpForNewsLetter(email);
    } catch (e) {}
  }

  Stream<UserState> _mapOtpVerificationToState(
      UserEvent event, UserState state, var otp) async* {
    try {
      final String isVerified = await userApi.otpVerification(otp);
    } catch (e) {}
  }

  Stream<UserState> _mapForgotPasswordToState(
      UserEvent event, UserState state, var email) async* {
    try {
      final String otp = await userApi.forgotPassword(email);
      otpValue = otp;
    } catch (e) {}
  }

  Stream<UserState> _mapCustomerLoginToState(
      UserEvent event, UserState state, CustomerRegistration customer) async* {
    yield CustomerLoginLoadingState();
    try {
      String tokenValue = await userApi.customerLogin(customer);
      print(tokenValue);
      this.token = tokenValue;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', customer.customerEmail);
      await prefs.setString('token', this.token);



        yield CustomerLoginSuccessState();
    } catch (e) {
      print('userbloc'+e.toString());
        yield CustomerLoginErrorState();
    }
  }

  Stream<UserState> _mapCheckMobileNumberStatusToState(
      UserEvent event, UserState state, var mobile) async* {
    yield CheckMobileNumberStatusLoadingState();
    try {
      final String status = await userApi.checkMobileNumberStatus(mobile);
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
      final String isSubscribed = await userApi.checkEmailSubScription(email);
    } catch (e) {}
  }

  Stream<UserState> _mapCheckEmailStatusToState(
      UserEvent event, UserState state, String mail) async* {
       
    yield CheckEmailStatusLoadingState();
    try {
      final bool status = await userApi.checkEmailStatus(mail);
      emailStatus = status;
      print("Email Status is" + emailStatus.toString());
      yield CheckEmailStatusLoadedState(emailStatus);
    } catch (e) {
      print(e);
    }
  }

  Stream<UserState> _mapFetchCustomerInformationToState(
      UserEvent event, UserState state, String mail) async* {
    yield CustomerInformationLoadingState();
    try {
      final CustomerRegistration info =
          await userApi.fetchCustomerInformation(mail);
      customer = info;
      //final storage = new FlutterSecureStorage();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Customer Id is>>>>>>>>>>>>>"+customer.customerId.toString());
      print("Customer>>>>>>>>>>>>>"+customer.toString());
      await prefs.setString('customerId', customer.customerId.toString());
     // await storage.write(
       //   key: "customerId", value: customer.customerId.toString());
      //await storage.write(key:"isRegistered",value: customer.customerId.toString());
      yield CustomerInformationLoadedState(customerlist: info);
    } catch (e) {
      print('error in fetching user information>>>>>> ' + e.toString());
    }
  }

  Stream<UserState> _mapFetchCustomerInformationUpdatedToState(
      UpdateCustomerEvent event, UserState state, String mail) async* {
    yield CustomerInformationLoadingState();
    try {
      await userApi.updateUser(event.customerRegistration);
      final CustomerRegistration info = await userApi
          .fetchCustomerInformation(event.customerRegistration.customerEmail);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Customer Id is>>>>>>>>>>>>>"+customer.customerId.toString());
      print("Customer>>>>>>>>>>>>>"+customer.toString());
      await prefs.setString('customerId', customer.customerId.toString());
      // final storage = new FlutterSecureStorage();
      // print(info);
      // await storage.write(
      //     key: "customerId", value: customer.customerId.toString());
      yield CustomerInformationUpdatedState(customerlist: info);
    } catch (e) {
      print('error in fetching user information>>>>>> ' + e.toString());
    }
  }
}
