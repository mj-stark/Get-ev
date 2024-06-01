import 'package:flutter/material.dart';
import 'package:get_ev/FrontPage.dart';
import 'package:get_ev/Signup.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _phoneNumberoremail;
  late String _password;
  late bool _phoneNumber1 = true;
  late bool _showOTPInput = false;
  late TextEditingController _otpController = TextEditingController();
  late bool _otpVerified = false;
  late TextEditingController emailOrPhone = TextEditingController();
  late TextEditingController password = TextEditingController();
  late TextEditingController emailOrPhoneupdate = TextEditingController();
  late TextEditingController passwordConfirm = TextEditingController();
  late TextEditingController passwordNew = TextEditingController();

  late bool _isProcessing = false;

  String _generateRandomOTP(int length) {
    final random = Random();

    return List.generate(length, (index) => random.nextInt(10)).join();
  }

  Future<void> _saveOTPToPreferences(String otp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('otp', otp);
  }

  Future<String?> _getSavedOTPFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('otp');
  }

  Future<void> _generateOTP() async {
    final String generatedOTP = _generateRandomOTP(4);

    await _saveOTPToPreferences(generatedOTP);

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
    sendUpdateRequest();
    setState(() {
      _showOTPInput = false;
      _otpVerified = false;
      _phoneNumber1 = true;
    });
  }

  Future<void> _sendUserData(BuildContext context) async {
    setState(() {
      _isProcessing = true;
    });

    final String emailOrPhoneText = emailOrPhone.text;
    final String passwordText = password.text;

    final url = Uri.parse(
        'https://9wtpck13-7229.inc1.devtunnels.ms/api/UserDetails/verify?emailOrPhone=$emailOrPhoneText&password=$passwordText');

    try {
      final response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Successful login
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FrontPage(
              emailorphno: emailOrPhoneText,
              password: passwordText,
            ),
          ),
        );
      } else {
        // Failed login
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid credentials. Please try again.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Error occurred
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to login. Error: $e'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> sendUpdateRequest() async {
    String apiUrl =
        'https://9wtpck13-7229.inc1.devtunnels.ms/api/UserDetails/update/${emailOrPhoneupdate.text}';
    Map<String, String> headers = {
      "accept": "/",
      "Content-Type": "application/json"
    };
    String jsonBody = jsonEncode({
      "email": emailOrPhoneupdate.text,
      "password": passwordConfirm.text,
    });

    // Sending PUT request
    var response =
        await http.put(Uri.parse(apiUrl), headers: headers, body: jsonBody);

    // Handling response
    if (response.statusCode == 200 || response.statusCode < 300) {
      // Success
      print('User details updated successfully');
      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password have been updated successfully!')),
      );
      // Hide OTP field and buttons after successful update
    } else {
      // Error
      print(
          'Failed to update user details. Status code: ${response.statusCode}');
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Failed to update password. Please try again later.')),
      );
      return;
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Your account has been created!'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
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
                          controller: emailOrPhone,
                          decoration: InputDecoration(
                            hintText: 'Email or Phone Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextField(
                          controller: password,
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
                                                        controller:
                                                            emailOrPhoneupdate,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Email or Phone Number',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            emailOrPhoneupdate
                                                                .text = value;
                                                            _phoneNumberoremail =
                                                                emailOrPhoneupdate
                                                                    .text;
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
                                                            final savedOTP =
                                                                _getSavedOTPFromPreferences();
                                                            if (savedOTP !=
                                                                savedOTP) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                    content: Text(
                                                                        'Invalid OTP!')),
                                                              );
                                                              return;
                                                            }
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
                                                        controller: passwordNew,
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
                                                            passwordConfirm,
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
                                                          if (passwordConfirm
                                                                  .text !=
                                                              passwordNew
                                                                  .text) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      'New Password and Confirm Password must be same')),
                                                            );
                                                            return;
                                                          }

                                                          setState(() {
                                                            _password =
                                                                passwordConfirm
                                                                    .text;
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
                              _sendUserData(context);
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
