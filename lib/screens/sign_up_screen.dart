import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {  usernameController.dispose(); emailController.dispose(); passwordController.dispose();super.dispose(); }

  void signUp() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
        ),
      );
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xff53B175).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_add_outlined,
                    size: 40,
                    color: Color(0xff53B175),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff181725),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your credentials to continue",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff7C7C7C),
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                "Username",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff7C7C7C),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: usernameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "Enter your username",
                  border: UnderlineInputBorder(),
                  suffixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff7C7C7C),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  border: UnderlineInputBorder(),
                  suffixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff7C7C7C),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  border: const UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff53B175),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Log In",
                          style: TextStyle(
                            color: Color(0xff53B175),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

