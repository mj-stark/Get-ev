import 'package:flutter/material.dart';
import 'package:get_ev/FrontPage.dart';
import 'package:get_ev/Signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        minTextAdapt: true, designSize: const Size(412, 868));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: Stack(
            children: [
              Container(
                height: 400.h,
                child: Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 200.w,
                    height: 250.h,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(screenHeight * 0.03)),
                  color: Colors.orange[300],
                ),
              ),
              Positioned(
                top: screenHeight * 0.4,
                left: screenWidth * 0.07,
                right: screenWidth * 0.07,
                child: Container(
                  width: screenWidth * 0.8,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: screenHeight * 0.01,
                        blurRadius: screenHeight * 0.02,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email or Phone Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(),
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.w,
                                                vertical: 30.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  'Forgot Password?',
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
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
                                                      const SizedBox(
                                                          height: 16),
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
                                                            _phoneNumber =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            _isProcessing =
                                                                true;
                                                            _showOTPInput =
                                                                true;
                                                          });
                                                          await _generateOTP();
                                                          setState(() {
                                                            _phoneNumber1 =
                                                                false;
                                                            _showOTPInput =
                                                                true;
                                                            _isProcessing =
                                                                false;
                                                          });
                                                        },
                                                        child: const Text(
                                                            'Send OTP'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: _showOTPInput,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 16),
                                                      TextField(
                                                        controller:
                                                            _otpController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Enter OTP',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _otpVerified = true;
                                                            _isProcessing =
                                                                true;
                                                          });
                                                          _verifyOTP();
                                                          setState(() {
                                                            _showOTPInput =
                                                                false;
                                                            _otpVerified = true;
                                                            _isProcessing =
                                                                false;
                                                          });
                                                        },
                                                        child: const Text(
                                                            'Verify OTP'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: _otpVerified,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 16),
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
                                                      const SizedBox(
                                                          height: 16),
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
                                                      const SizedBox(
                                                          height: 16),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _otpVerified = true;
                                                            _changePassword();
                                                            Navigator.pop(
                                                                context);
                                                            _isProcessing =
                                                                true;
                                                          });

                                                          setState(() {
                                                            _isProcessing =
                                                                false;
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.w, vertical: 5.h),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: 150.w,
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
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.03),
                              ),
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30.h,
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
                      child: Text(
                        "Don't have an account? Register",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.sp,
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
