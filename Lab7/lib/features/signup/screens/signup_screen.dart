import 'package:flutter/material.dart';

import '../models/signup_form_data.dart';
import '../services/email_availability_service.dart';
import '../validators/signup_validators.dart';
import '../widgets/password_strength_indicator.dart';
import '../widgets/signup_header.dart';
import '../widgets/signup_submit_button.dart';
import '../widgets/signup_text_field.dart';
import '../widgets/terms_acceptance_tile.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
    this.emailService = const FakeEmailAvailabilityService(),
  });

  final EmailAvailabilityService emailService;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldKey = GlobalKey<FormFieldState<String>>();
  final _confirmPasswordFieldKey = GlobalKey<FormFieldState<String>>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool _acceptedTerms = false;
  bool _showTermsError = false;
  bool _isCheckingEmail = false;
  String? _emailServerError;

  String _savedName = '';
  String _savedEmail = '';
  String _savedPassword = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _emailServerError = null;
      _showTermsError = !_acceptedTerms;
    });

    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid || !_acceptedTerms) {
      return;
    }

    _formKey.currentState!.save();
    final formData = SignupFormData(
      fullName: _savedName,
      email: _savedEmail,
      password: _savedPassword,
    );

    setState(() => _isCheckingEmail = true);
    final isEmailAvailable = await widget.emailService.isEmailAvailable(
      formData.email,
    );
    if (!mounted) return;

    if (!isEmailAvailable) {
      setState(() {
        _isCheckingEmail = false;
        _emailServerError = 'This email is already taken';
      });
      _emailFieldKey.currentState?.validate();
      _emailFocusNode.requestFocus();
      _showMessage('This email is already taken', isError: true);
      return;
    }

    setState(() => _isCheckingEmail = false);
    _showMessage('Account created successfully for ${formData.fullName}!');
  }

  void _showMessage(String message, {bool isError = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(message)),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError
              ? colorScheme.error
              : const Color(0xFF267A4A),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SignupHeader(),
                        const SizedBox(height: 28),
                        _buildNameField(),
                        const SizedBox(height: 16),
                        _buildEmailField(),
                        const SizedBox(height: 16),
                        _buildPasswordField(),
                        const SizedBox(height: 10),
                        PasswordStrengthIndicator(
                          strength: SignupValidators.passwordStrength(
                            _passwordController.text,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildConfirmPasswordField(),
                        const SizedBox(height: 10),
                        TermsAcceptanceTile(
                          value: _acceptedTerms,
                          showError: _showTermsError,
                          onChanged: _isCheckingEmail
                              ? null
                              : (value) {
                                  setState(() {
                                    _acceptedTerms = value ?? false;
                                    _showTermsError = false;
                                  });
                                },
                        ),
                        const SizedBox(height: 10),
                        SignupSubmitButton(
                          isLoading: _isCheckingEmail,
                          onPressed: _submit,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return SignupTextField(
      fieldKey: const Key('nameField'),
      enabled: !_isCheckingEmail,
      controller: _nameController,
      focusNode: _nameFocusNode,
      label: 'Full name',
      hint: 'Nguyen Van A',
      prefixIcon: Icons.person_outline,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      validator: SignupValidators.name,
      onSaved: (value) => _savedName = value!.trim(),
      onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
    );
  }

  Widget _buildEmailField() {
    return SignupTextField(
      fieldKey: _emailFieldKey,
      enabled: !_isCheckingEmail,
      controller: _emailController,
      focusNode: _emailFocusNode,
      label: 'Email',
      hint: 'name@example.com',
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      autofillHints: const [AutofillHints.email],
      validator: (value) =>
          SignupValidators.email(value, serverError: _emailServerError),
      onChanged: (_) {
        if (_emailServerError != null) {
          setState(() => _emailServerError = null);
        }
      },
      onSaved: (value) => _savedEmail = value!.trim(),
      onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
    );
  }

  Widget _buildPasswordField() {
    return SignupTextField(
      fieldKey: const Key('passwordField'),
      enabled: !_isCheckingEmail,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      label: 'Password',
      prefixIcon: Icons.lock_outline,
      obscureText: _hidePassword,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: const [AutofillHints.newPassword],
      suffixIcon: IconButton(
        key: const Key('togglePassword'),
        tooltip: _hidePassword ? 'Show password' : 'Hide password',
        onPressed: () => setState(() => _hidePassword = !_hidePassword),
        icon: Icon(
          _hidePassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
      ),
      validator: SignupValidators.password,
      onChanged: (_) {
        setState(() {});
        if (_confirmPasswordController.text.isNotEmpty) {
          _confirmPasswordFieldKey.currentState?.validate();
        }
      },
      onSaved: (value) => _savedPassword = value!,
      onFieldSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
    );
  }

  Widget _buildConfirmPasswordField() {
    return SignupTextField(
      fieldKey: _confirmPasswordFieldKey,
      enabled: !_isCheckingEmail,
      controller: _confirmPasswordController,
      focusNode: _confirmPasswordFocusNode,
      label: 'Confirm password',
      prefixIcon: Icons.lock_reset_outlined,
      obscureText: _hideConfirmPassword,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: const [AutofillHints.newPassword],
      suffixIcon: IconButton(
        key: const Key('toggleConfirmPassword'),
        tooltip: _hideConfirmPassword ? 'Show password' : 'Hide password',
        onPressed: () =>
            setState(() => _hideConfirmPassword = !_hideConfirmPassword),
        icon: Icon(
          _hideConfirmPassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
      ),
      validator: (value) =>
          SignupValidators.confirmPassword(value, _passwordController.text),
      onFieldSubmitted: (_) => _submit(),
    );
  }
}
