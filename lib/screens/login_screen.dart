import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {   emailController.dispose();   passwordController.dispose();   super.dispose(); }

  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter email and password"),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(), // تم ضبطها بـ const هنا بنجاح وبدون أي إيرور
      ),
    );
  }

  void openSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
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
                child: Image.asset(
                  "assets/images/Group.png",
                  width: 70,
                  height: 70,
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff181725),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your email and password",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff7C7C7C),
                ),
              ),
              const SizedBox(height: 35),
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
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Color(0xff181725),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff53B175),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Log In",
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
                  onTap: openSignUp,
                  child: RichText(
                    text: const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign Up",
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