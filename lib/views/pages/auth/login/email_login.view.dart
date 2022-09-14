import 'package:flutter/material.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/view_models/login.view_model.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class EmailLoginView extends StatelessWidget {
  const EmailLoginView(this.model, {Key key}) : super(key: key);

  final LoginViewModel model;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !model.otpLogin,
      child: Form(
        key: model.formKey,
        child: VStack(
          [
            //
            CustomTextFormField(
              labelText: "Email".tr(),
              keyboardType: TextInputType.emailAddress,
              textEditingController: model.emailTEC,
              validator: FormValidator.validateEmail,
            ).py12(),
            CustomTextFormField(
              labelText: "Password".tr(),
              obscureText: true,
              textEditingController: model.passwordTEC,
              validator: FormValidator.validatePassword,
            ).py12(),

            //
            "Forgot Password ?".tr().text.underline.make().onInkTap(
                  model.openForgotPassword,
                ),
            //
            CustomButton(
              title: "Login".tr(),
              loading: model.isBusy,
              onPressed: model.processLogin,
            ).centered().py12(),
//otp login
            "Login with Phone Number"
                .tr()
                .text
                .semiBold
                .makeCentered()
                .py12()
                .onInkTap(model.toggleLoginType),
            //register
            "OR".tr().text.light.makeCentered(),
            "Create An Account"
                .tr()
                .text
                .semiBold
                .makeCentered()
                .py12()
                .onInkTap(model.openRegister),
          ],
          crossAlignment: CrossAxisAlignment.end,
        ),
      ).py20(),
    );
  }
}
