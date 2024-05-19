import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_ev/Phoneotp.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenHeight * 0.025, // Responsive font size
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true, // Center the title
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(screenHeight * 0.02), // Responsive padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Center(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Email ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Center(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Center(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Center(
                      child: Container(
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.4,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Phoneotp();
                                },
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_forward),
                          label: Text(
                            'Next',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.018, // Responsive font size
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenHeight * 0.03),
                            ),
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
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
