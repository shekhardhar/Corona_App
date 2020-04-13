class IUserService {
  Future<int> LoginUser(Map loginData) async {}
  Future<int> SendOTP(Map sendOTPData) async {}
  Future<int> ValidateOTP(Map validateOTPData) async {}
  Future<int> ResetPassword(Map registerData) async {}
  // Future<int> RegisterUser(RegisterUserModel registerData) async{}
  Future<int> RegisterUser(Map registerData) async {}
  Future<int> MyAccount(Map myaccountData) async {}
  Future<int> ChangePassword(Map changePasswordData) async {}
  Future<int> Drawer(Map drawerData) async {}
  //Future<int> RegisterUser(Map registerData) async{}
}
