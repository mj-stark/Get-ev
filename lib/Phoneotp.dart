import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_ev/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Phoneotp extends StatefulWidget {
  const Phoneotp({Key? key}) : super(key: key);

  @override
  State<Phoneotp> createState() => _PhoneotpState();
}

class _PhoneotpState extends State<Phoneotp> {
  String _phoneNumber = '';

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String _enteredOTP = '';
  String _selectedCountryCode = '+1'; // Default country code
  bool _otpGenerated = false;

  Future<void> _generateOTP() async {
    // Generate OTP logic here
    // For demo purposes, generating a random 4-digit OTP
    final String generatedOTP = _generateRandomOTP(4);
    setState(() {
      _enteredOTP = controllers[0].text +
          controllers[1].text +
          controllers[2].text +
          controllers[3].text;
      _otpGenerated = true;
    });
    await _saveOTPToPreferences(generatedOTP);
    _showOTPDialog();
  }

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

  void _showOTPDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('OTP'),
        content: FutureBuilder<String?>(
          future: _getSavedOTPFromPreferences(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator while fetching OTP
            } else {
              return Text('Your OTP is ${snapshot.data ?? _enteredOTP}');
            }
          },
        ),
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

  Widget buildTextField(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: TextField(
          controller: controllers[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              // Auto navigate to next text field on input
              if (index < 3) {
                FocusScope.of(context).nextFocus();
              } else {
                // Do something when the last field is filled
              }
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Phone OTP Verification',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                DropdownButton<String>(
                  alignment: Alignment.center,
                  itemHeight: screenHeight * 0.1,
                  menuMaxHeight: screenHeight * 0.1,
                  value: _selectedCountryCode,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCountryCode = newValue!;
                    });
                  },
                  items: [
                    '+91',
                    '+7',
                    '+20',
                    // Add other country codes as needed
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenHeight * 0.02),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            if (_otpGenerated)
              Row(
                children: [
                  buildTextField(0),
                  buildTextField(1),
                  buildTextField(2),
                  buildTextField(3),
                ],
              ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              onPressed: () async {
                await _generateOTP();
              },
              child: Text(
                'Generate OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.025,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenHeight * 0.03),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final savedOTP = await _getSavedOTPFromPreferences();

                _enteredOTP = controllers[0].text +
          controllers[1].text +
          controllers[2].text +
          controllers[3].text;
      _otpGenerated = true;
                if (_enteredOTP == savedOTP) {
                  
                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ),
                            );
                            _showSuccessDialog();
                } else {
                  // Handle incorrect OTP
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Incorrect OTP. Please try again.'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              child: Text(
                'Verify OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.025,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenHeight * 0.03),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
