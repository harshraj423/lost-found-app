class AuthFormState {
  final String name;
  final String email;
  final String password;
  final bool isPasswordHidden;
  final bool isLoading;
  final String? nameError;
  final String? emailError;
  final String? passwordError;

  AuthFormState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.isPasswordHidden = true,
    this.isLoading = false,
    this.nameError,
    this.emailError,
    this.passwordError,
  });

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      (name.isEmpty || nameError == null);

  AuthFormState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isPasswordHidden,
    bool? isLoading,
    String? nameError,
    String? emailError,
    String? passwordError,
  }) {
    return AuthFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isLoading: isLoading ?? this.isLoading,
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
    );
  }
}
