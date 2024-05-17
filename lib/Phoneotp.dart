import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Phoneotp extends StatefulWidget {
  const Phoneotp({Key? key}) : super(key: key);

  @override
  State<Phoneotp> createState() => _PhoneotpState();
}

class _PhoneotpState extends State<Phoneotp> {
  String _phoneNumber = '';
  String _enteredOTP = '';
  String _selectedCountryCode = '+1'; // Default country code

  void _generateOTP() {
    // Generate OTP logic here
    // For demo purposes, generating a random 6-digit OTP
    setState(() {
      _enteredOTP = '123456'; // Replace with actual OTP generation logic
    });
    _showOTPDialog();
  }

  void _showOTPDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('OTP'),
        content: Text('Your OTP is $_enteredOTP'),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                DropdownButton<String>(
                  alignment: Alignment.center,
                  itemHeight: 70,
                  menuMaxHeight: 70,
                  value: _selectedCountryCode,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCountryCode = newValue!;
                    });
                  },
                  items: [
                    '+1',
                    '+7',
                    '+20',
                    '+27',
                    '+30',
                    '+31',
                    '+32',
                    '+33',
                    '+34',
                    '+36',
                    '+39',
                    '+40',
                    '+41',
                    '+43',
                    '+44',
                    '+45',
                    '+46',
                    '+47',
                    '+48',
                    '+49',
                    '+51',
                    '+52',
                    '+53',
                    '+54',
                    '+55',
                    '+56',
                    '+57',
                    '+58',
                    '+60',
                    '+61',
                    '+62',
                    '+63',
                    '+64',
                    '+65',
                    '+66',
                    '+81',
                    '+82',
                    '+84',
                    '+86',
                    '+90',
                    '+91',
                    '+92',
                    '+93',
                    '+94',
                    '+95',
                    '+98',
                    '+211',
                    '+212',
                    '+213',
                    '+216',
                    '+218',
                    '+220',
                    '+221',
                    '+222',
                    '+223',
                    '+224',
                    '+225',
                    '+226',
                    '+227',
                    '+228',
                    '+229',
                    '+230',
                    '+231',
                    '+232',
                    '+233',
                    '+234',
                    '+235',
                    '+236',
                    '+237',
                    '+238',
                    '+239',
                    '+240',
                    '+241',
                    '+242',
                    '+243',
                    '+244',
                    '+245',
                    '+246',
                    '+248',
                    '+249',
                    '+250',
                    '+251',
                    '+252',
                    '+253',
                    '+254',
                    '+255',
                    '+256',
                    '+257',
                    '+258',
                    '+260',
                    '+261',
                    '+262',
                    '+263',
                    '+264',
                    '+265',
                    '+266',
                    '+267',
                    '+268',
                    '+269',
                    '+290',
                    '+291',
                    '+297',
                    '+298',
                    '+299',
                    '+350',
                    '+351',
                    '+352',
                    '+353',
                    '+354',
                    '+355',
                    '+356',
                    '+357',
                    '+358',
                    '+359',
                    '+370',
                    '+371',
                    '+372',
                    '+373',
                    '+374',
                    '+375',
                    '+376',
                    '+377',
                    '+378',
                    '+379',
                    '+380',
                    '+381',
                    '+382',
                    '+383',
                    '+385',
                    '+386',
                    '+387',
                    '+389',
                    '+420',
                    '+421',
                    '+423',
                    '+500',
                    '+501',
                    '+502',
                    '+503',
                    '+504',
                    '+505',
                    '+506',
                    '+507',
                    '+508',
                    '+509',
                    '+590',
                    '+591',
                    '+592',
                    '+593',
                    '+595',
                    '+597',
                    '+598',
                    '+599',
                    '+670',
                    '+672',
                    '+673',
                    '+674',
                    '+675',
                    '+676',
                    '+677',
                    '+678',
                    '+679',
                    '+680',
                    '+681',
                    '+682',
                    '+683',
                    '+685',
                    '+686',
                    '+687',
                    '+688',
                    '+689',
                    '+690',
                    '+691',
                    '+692',
                    '+850',
                    '+852',
                    '+853',
                    '+855',
                    '+856',
                    '+880',
                    '+886',
                    '+960',
                    '+961',
                    '+962',
                    '+963',
                    '+964',
                    '+965',
                    '+966',
                    '+967',
                    '+968',
                    '+970',
                    '+971',
                    '+972',
                    '+973',
                    '+974',
                    '+975',
                    '+976',
                    '+977',
                    '+992',
                    '+993',
                    '+994',
                    '+995',
                    '+996',
                    '+998',
                    '+1-242',
                    '+1-246',
                    '+1-264',
                    '+1-268',
                    '+1-284',
                    '+1-340',
                    '+1-345',
                    '+1-441',
                    '+1-473',
                    '+1-649',
                    '+1-664',
                    '+1-670',
                    '+1-671',
                    '+1-684',
                    '+1-721',
                    '+1-758',
                    '+1-767',
                    '+1-784',
                    '+1-787',
                    '+1-809',
                    '+1-868',
                    '+1-869',
                    '+1-876',
                    '+44-1481',
                    '+44-1534'
                  ] // Example country codes
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
            SizedBox(height: 40),
            Row(
              children: [
                for (int i = 0; i < 4; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextField(
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
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateOTP,
              child: Text(
                'Generate OTP',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
