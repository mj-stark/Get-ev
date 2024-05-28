import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name = '';
  late String email = '';
  late String phoneNo = '';
  late String address = '';
  late String imageUrl = '';
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneNoController = TextEditingController();
  late TextEditingController addressController = TextEditingController();

  
  String otp = '';
  bool showOTPField = false; // Track visibility of OTP field and buttons

  @override
  void initState() {
    super.initState();
    // Initialize profile details
    name = nameController.text;
    email = 'stark@gmail.com';
    phoneNo = phoneNoController.text;
    address = addressController.text;
    imageUrl = 'assets/profile_image.jpg'; // Replace with your image asset path
  }

  void updateProfile() {
    setState(() {
      otp = generateOTP();
      showOTPField = true; // Show OTP field and buttons when Update is pressed
    });
    // Code to send OTP via email or SMS
    // For demo purposes, printing OTP to console
    print('OTP: $otp');
    print('OTP: $email');
  }

  String generateOTP() {
    // Generate a 6-digit random OTP
    Random random = Random();
    String otp = '';
    for (int i = 0; i < 6; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }

  Future<void> sendUpdateRequest() async {
    String apiUrl =
        'https://9wtpck13-7229.inc1.devtunnels.ms/api/UserDetails/updatedata/$email';
    Map<String, String> headers = {
      "accept": "/",
      "Content-Type": "application/json"
    };
    String jsonBody = jsonEncode({
      "name": name,
      "password": "mj@123",
      "address": address,
      "email": email,
      "phoneNo": phoneNo
    });

    // Sending PUT request
    var response =
        await http.put(Uri.parse(apiUrl), headers: headers, body: jsonBody);

    // Handling response
    if (response.statusCode == 200 && response.statusCode < 300) {
      // Success
      print('User details updated successfully');
      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
      // Hide OTP field and buttons after successful update
      setState(() {
        showOTPField = false;
      });
    } else {
      // Error
      print(
          'Failed to update user details. Status code: ${response.statusCode}');
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to update profile. Please try again later.')),
      );
    }
  }

  void verifyOTP(String enteredOTP) {
    if (enteredOTP == otp) {
      sendUpdateRequest();
      setState(() {
        
        showOTPField =
            false; // Hide OTP field and buttons after successful verification
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // Display Profile Image at the top center
              CircleAvatar(
                radius: 50.r,
                backgroundImage: AssetImage(imageUrl),
              ),
              SizedBox(height: 20.h),
              // Input fields for name, email, phone number, and address
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  
                  onChanged: (value) => name = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  
                  onChanged: (value) => email = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: TextFormField(
                  controller: phoneNoController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  
                  onChanged: (value) => phoneNo = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  
                  onChanged: (value) => address = value,
                ),
              ),
              SizedBox(height: 20.h),
              // Update Button
              ElevatedButton(
                onPressed: updateProfile,
                child: Text('Update'),
              ),
              SizedBox(height: 20.h),
              // OTP field and buttons (visible only when Update is pressed)
              Visibility(
                visible: showOTPField,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Enter OTP'),
                        onChanged: verifyOTP,
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            otp = generateOTP(); // Regenerate OTP
                          });
                          print('New OTP: $otp');
                        },
                        child: Text('Generate OTP'),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          // No action needed for verifying OTP here, it's handled in verifyOTP function
                        },
                        child: Text('Verify OTP'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
