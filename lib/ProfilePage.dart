import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name;
  late String email;
  late String phoneNo;
  late String address;
  late String imageUrl;
  String otp = '';
  bool showOTPField = false; // Track visibility of OTP field and buttons

  @override
  void initState() {
    super.initState();
    // Initialize profile details
    name = 'John Doe';
    email = 'johndoe@example.com';
    phoneNo = '1234567890';
    address = '123, Street Name, City';
    imageUrl = 'assets/profile_image.jpg'; // Replace with your image asset path
  }

  void updateProfile() {
    // Generate and send OTP logic
    setState(() {
      otp = generateOTP();
      showOTPField = true; // Show OTP field and buttons when Update is pressed
    });
    // Code to send OTP via email or SMS
    // For demo purposes, printing OTP to console
    print('OTP: $otp');
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

  void verifyOTP(String enteredOTP) {
    if (enteredOTP == otp) {
      // Update profile logic
      setState(() {
        // Example: Update profile with new details
        name = 'Updated Name';
        email = 'updatedemail@example.com';
        phoneNo = '9876543210';
        address = '456, Updated Street, City';
        showOTPField =
            false; // Hide OTP field and buttons after successful verification
      });
      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
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
                  decoration: InputDecoration(labelText: 'Name'),
                  initialValue: name,
                  onChanged: (value) => name = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  initialValue: email,
                  onChanged: (value) => email = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  initialValue: phoneNo,
                  onChanged: (value) => phoneNo = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                  initialValue: address,
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
