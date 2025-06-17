import 'package:brewmate_coffee_app/services/authservice.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  bool isChecked = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to Terms & Privacy')),
      );
      return;
    }

    final email = _emailController.text.trim();
    final name = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();

    if (email.isEmpty || name.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email, username, and password are required')),
      );
      return;
    }

    final newUser = await _authService.registerAccount(
      name: name,
      email: email,
      password: password,
      phoneNumber: phone.isNotEmpty ? phone : null,
      address: address.isNotEmpty ? address : null,
    );

    if (newUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/login.png'),
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 40, right: 40, bottom: 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Create your new account.',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Create an account to start looking for the food you like.',
                      style: TextStyle(fontSize: 12, color: Colors.grey[200]),
                    ),
                    const SizedBox(height: 10),
                    buildTextField('Email', 'Enter email', _emailController),
                    const SizedBox(height: 10),
                    buildTextField('Username', 'Enter username', _usernameController),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Password',
                            style: TextStyle(fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 3),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                              const  EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            hintText: 'Enter password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    buildTextField('Phone Number ', 'Enter phone number', _phoneController),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                          activeColor: Colors.orange[500],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('I agree to the',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                                      Text(' Terms of Service',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange[500],
                                        fontWeight: FontWeight.bold)),
                                const Text(' and ',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ],
                            ),
                            Text('Privacy Policy',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.orange[500],
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: _registerUser,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.orange[500],
                        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 3),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          height: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Divider(color: Colors.grey),
                        Text('Or login with',
                            style: TextStyle(fontSize: 12, color: Colors.white)),
                        Divider(color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Image.asset('assets/google.png', width: 25, height: 25),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Image.asset('assets/facebook.png', width: 25, height: 25),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Image.asset('assets/apple.png', width: 40, height: 40),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange[500],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build consistent input fields
  Widget buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, color: Colors.white)),
        const SizedBox(height: 3),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            hintText: hint,
          ),
        ),
      ],
    );
  }
}
