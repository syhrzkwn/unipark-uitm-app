import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:unipark_uitm_app/src/constants/images.dart';
import 'package:unipark_uitm_app/src/constants/sizes.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: const AssetImage(uniparkLogo),
                  height: size.height * 0.08,
                ),
              ),
              const Gap(60.0),
              Text(
                'Enter 6-digit OTP',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(10.0),
              Text(
                "An OTP was sent to syahirzakwan.dev@gmail.com for verification",
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              const Gap(20.0),
              OtpTextField(
                numberOfFields: 6,
                onSubmit: (code) {
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text("Verification Code"),
                        content: Text('Code entered is $code'),
                      );
                    }
                  );
                },
              ),
              const Gap(30.0),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: const Text('Verify'),
              //   ),
              // ),
              // const Gap(20.0),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Request for a new OTP in 45 seconds',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}