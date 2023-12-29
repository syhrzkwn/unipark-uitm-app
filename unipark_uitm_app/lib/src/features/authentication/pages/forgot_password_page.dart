import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/authentication/controllers/forgot_password_controller.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';
import 'package:unipark_uitm_app/src/utils/widgets/textformfield_outline_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = HelperFunction.screenSize();
    final controller = Get.put(ForgotPasswordController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(defaultSize, 0.0, defaultSize, defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: const AssetImage(forgotPassword),
                  height: size.height * 0.4,
                ),
              ),
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(10.0),
              Text(
                "Don't worry sometimes people can forget too, enter your email and we will send you a secure link to reset your password",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(30.0),
              Form(
                key: controller.forgotPasswordFormKey,
                child: Column(
                  children: [
                    WTextFormFieldOutline(
                      controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Validations.validateEmail(value),
                      labelText: 'Email',
                      hintText: 'Email',
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    const Gap(20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.sendEmailResetPassword(),
                        child: const Text('Request'),
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
