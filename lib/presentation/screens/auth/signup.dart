import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Top spacing
                      const SizedBox(height: 60),

                      // 1. Headline
                      const Text(
                        'Create Your Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1F36), // Dark Navy
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // 2. Input Fields
                      // Assuming standard flow: Name, Email, Password, Confirm
                      _buildInputField(
                        controller: _nameController,
                        hintText: 'Full Name',
                        isObscure: false,
                      ),
                      const SizedBox(height: 16),

                      _buildInputField(
                        controller: _emailController,
                        hintText: 'Email',
                        isObscure: false,
                      ),
                      const SizedBox(height: 16),

                      _buildInputField(
                        controller: _passwordController,
                        hintText: 'Password',
                        isObscure: true,
                      ),
                      const SizedBox(height: 16),

                      _buildInputField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        isObscure: true,
                      ),

                      const SizedBox(height: 24),

                      // 3. Terms Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _agreeToTerms,
                              activeColor: const Color(0xFF5865F2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              side: const BorderSide(
                                color: Color(0xFFE0E0E0),
                                width: 1.5,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _agreeToTerms = value ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                text: 'I agree to the ',
                                style: TextStyle(
                                  color: Color(0xFF697386),
                                  fontSize: 14,
                                  height: 1.4,
                                  fontFamily: 'Roboto',
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(
                                      color: Color(0xFF5865F2),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: Color(0xFF5865F2),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // 4. Sign Up Button
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFF5865F2), // Vibrant Blurple
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5865F2)
                                  .withValues(alpha: 0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                              spreadRadius: -5,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              final name = _nameController.text.trim();
                              final email = _emailController.text.trim();
                              final password = _passwordController.text;
                              final confirmPassword =
                                  _confirmPasswordController.text;

                              if (name.isEmpty ||
                                  email.isEmpty ||
                                  password.isEmpty ||
                                  confirmPassword.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill all fields')),
                                );
                                return;
                              }

                              if (!email.contains('@')) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Please enter a valid email')),
                                );
                                return;
                              }

                              if (password.length < 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Password must be at least 6 characters')),
                                );
                                return;
                              }

                              if (password != confirmPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Passwords do not match')),
                                );
                                return;
                              }

                              if (!_agreeToTerms) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Please agree to the terms')),
                                );
                                return;
                              }

                              try {
                                // Example using Supabase (replace with your own auth provider call)
                                // final response = await Supabase.instance.client.auth.signUp(
                                //   email: email,
                                //   password: password,
                                //   data: {'name': name},
                                // );
                                // if (response.user == null) throw 'Signup failed';

                                // Example using Firebase (replace with your own auth provider call)
                                // final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                //   email: email,
                                //   password: password,
                                // );
                                // await credential.user?.updateDisplayName(name);

                                // On success navigate to OTP
                                context.go(
                                    '/otp?email=${Uri.encodeComponent(email)}');
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Registration error: $e')),
                                );
                              }
                              context.go(
                                  '/otp?email=${Uri.encodeComponent(email)}');
                            },
                            child: const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      // 5. Footer Login Link
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: GestureDetector(
                          onTap: () => context.go('/login'),
                          child: RichText(
                            text: const TextSpan(
                              text: "Already have account? ",
                              style: TextStyle(
                                color: Color(0xFF697386), // Slate Grey
                                fontSize: 15,
                                fontFamily: 'Roboto',
                              ),
                              children: [
                                TextSpan(
                                  text: 'log in',
                                  style: TextStyle(
                                    color: Color(0xFF5865F2),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required bool isObscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0), // Light grey border
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF1A1F36),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
