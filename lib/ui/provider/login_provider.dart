import 'package:flutter/cupertino.dart';
import 'package:kuncie/repository/users_repository.dart';
import 'package:kuncie/service/auth_result.dart';
import 'package:kuncie/service/auth_service.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/utils/validate.dart';
import 'package:kuncie/utils/validate_result.dart';
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider(this.usersRepository) {
    this.authService = AuthService(usersRepository);
  }

  final UsersRepository usersRepository;
  late AuthService authService;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValidateResult? emailValidate;
  ValidateResult? passwordValidate;
  bool submited = false;
  bool showPassword = false;

  void showAndHidePassword() {
    showPassword = !showPassword;

    notifyListeners();
  }

  void validateEmail() {
    this.emailValidate = Validate.email(emailController.text);
    notifyListeners();
  }

  void validatePassword() {
    this.passwordValidate = Validate.password(passwordController.text);
    notifyListeners();
  }

  bool get validate =>
      this.emailValidate != null &&
      this.emailValidate!.success &&
      this.passwordValidate != null &&
      this.passwordValidate!.success;

  void resetForm() {
    emailValidate = null;
    passwordValidate = null;
    submited = false;
    showPassword = false;
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  Future<AuthResult> login() async {
    AuthResult result;
    submited = true;
    validateEmail();
    validatePassword();

    if (validate) {
      result = await authService.login(
          emailController.text, passwordController.text);
      if (result.success) resetForm();
    } else
      result = AuthResult(false,
          message: emailValidate?.message ?? passwordValidate?.message);

    notifyListeners();
    return result;
  }
}
