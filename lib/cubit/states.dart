abstract class IhealthStates {}

class IhealthInitialState extends IhealthStates {}

class ChangeBottomNavState extends IhealthStates {}

class ChangePasswordVisibilityState extends IhealthStates {}

class LoginLoadingState extends IhealthStates {}

class LoginSuccessState extends IhealthStates
{
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends IhealthStates
{
  final String  error;
  LoginErrorState(this.error);
}
class RegisterLoadingState extends IhealthStates {}

class RegisterSuccessState extends IhealthStates {}

class RegisterErrorState extends IhealthStates
{
  final String  error;
  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends IhealthStates {}

class CreateUserErrorState extends IhealthStates
{
  final String  error;
  CreateUserErrorState(this.error);
}

class AppCreateDatabaseState extends IhealthStates {}

class AppGetDatabaseState extends IhealthStates {}

class AppGetDatabaseLoadingState extends IhealthStates {}

class AppInsertDatabaseState extends IhealthStates {}

class AppChangeBottomSheetState extends IhealthStates {}

class AppUpdateDatabaseState extends IhealthStates {}

class AppDeleteDatabaseState extends IhealthStates {}
