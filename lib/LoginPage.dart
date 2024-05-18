import 'package:flutter/material.dart';
import 'package:get_ev/FrontPage.dart';
import 'package:get_ev/Signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _phoneNumber;
  late bool _phoneNumber1 = true;
  late bool _showOTPInput = false;
  late TextEditingController _otpController = TextEditingController();
  late bool _otpVerified = false;
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _confirmPasswordController =
      TextEditingController();
  late bool _isProcessing = false;

  Future<void> _generateOTP() async {
    // Generate OTP logic here
    // For demo purposes, setting a default OTP
    final String generatedOTP = '1234';

    // Show the OTP in an alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Generated OTP'),
          content: Text('Your OTP is: $generatedOTP'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _verifyOTP() {
    // Implement OTP verification logic here
    // For demo purposes, just set _otpVerified to true
    setState(() {
      _otpVerified = true;
    });
  }

  void _changePassword() {
    // Implement password change logic here
    // For demo purposes, just print the new password
    print('New Password: ${_passwordController.text}');

    // Show success alert
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Your password has been changed successfully.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.orange[300],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.4,
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        child: Container(
                          height: 70,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: SingleChildScrollView(
                                        // Wrap content with SingleChildScrollView
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                'Forgot Password?',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              const Text(
                                                'Enter your email or phone number to reset your password',
                                                textAlign: TextAlign.center,
                                              ),
                                              Visibility(
                                                visible: _phoneNumber1,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 16),
                                                    TextField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Email or Phone Number',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _phoneNumber = value;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 16),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          _isProcessing = true;
                                                          _showOTPInput = true;
                                                        });
                                                        await _generateOTP();
                                                        setState(() {
                                                          _phoneNumber1 = false;
                                                          _showOTPInput = true;
                                                          _isProcessing = false;
                                                        });
                                                      },
                                                      child: const Text('Send OTP'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: _showOTPInput,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 16),
                                                    TextField(
                                                      controller:
                                                          _otpController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Enter OTP',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _otpVerified = true;
                                                          _isProcessing = true;
                                                        });
                                                        _verifyOTP();
                                                        setState(() {
                                                          _showOTPInput = false;
                                                          _otpVerified = true;
                                                          _isProcessing = false;
                                                        });
                                                      },
                                                      child: const Text('Verify OTP'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: _otpVerified,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 16),
                                                    TextField(
                                                      controller:
                                                          _passwordController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'New Password',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      obscureText: true,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    TextField(
                                                      controller:
                                                          _confirmPasswordController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Confirm Password',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      obscureText: true,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _otpVerified = true;
                                                          _changePassword();
                                                          Navigator.pop(
                                                              context);
                                                          _isProcessing = true;
                                                        });

                                                        setState(() {
                                                          _isProcessing = false;
                                                        });
                                                        // Close the modal
                                                      },
                                                      child: const Text(
                                                          'Change Password'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                },
                              );
                            },
                          );
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const FrontPage();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignupPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Register",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
