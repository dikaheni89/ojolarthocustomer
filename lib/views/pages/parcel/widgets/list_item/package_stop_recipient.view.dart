import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/views/pages/parcel/widgets/parcel_form_input.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class PackageStopRecipientView extends StatefulWidget {
  const PackageStopRecipientView(
    this.stop,
    this.recipientNameTEC,
    this.recipientPhoneTEC,
    this.noteTEC, {
    Key key,
    this.isOpen = false,
    this.viewKey,
  }) : super(key: key);

  final DeliveryAddress stop;
  final TextEditingController recipientNameTEC;
  final TextEditingController recipientPhoneTEC;
  final TextEditingController noteTEC;
  final bool isOpen;
  final Key viewKey;

  @override
  _PackageStopRecipientViewState createState() =>
      _PackageStopRecipientViewState();
}

class _PackageStopRecipientViewState extends State<PackageStopRecipientView> {
  //
  bool isOpen = true;

  @override
  void initState() {
    super.initState();
    isOpen = widget.isOpen;
  }

  //
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        HStack(
          [
            ("Contact Info".tr() + " (${widget.stop.name})")
                .text
                .xl
                .medium
                .make()
                .expand(),
            Icon(
              isOpen ? FlutterIcons.caret_down_faw : FlutterIcons.caret_up_faw,
              color: AppColor.primaryColor,
            ),
          ],
        ).onInkTap(() {
          //
          setState(() {
            isOpen = !isOpen;
          });
        }),

        //
        Visibility(
            key: widget.viewKey,
            visible: isOpen,
            child: VStack(
              [
                UiSpacer.verticalSpace(),
                //pick contact btn
                CustomButton(
                  title: "Pick from Phonebook".tr(),
                  onPressed: _openContactPicker,
                ),
                UiSpacer.verticalSpace(),
                //name
                ParcelFormInput(
                  isReadOnly: false,
                  iconData: FlutterIcons.user_fea,
                  iconColor: AppColor.primaryColor,
                  labelText: "Name".tr().toUpperCase(),
                  hintText: "Contact Name".tr(),
                  tec: widget.recipientNameTEC,
                  formValidator: (value) => FormValidator.validateCustom(
                    value,
                    name: "Name".tr(),
                  ),
                ),
                UiSpacer.formVerticalSpace(),
                //phone
                ParcelFormInput(
                  isReadOnly: false,
                  iconData: FlutterIcons.phone_fea,
                  iconColor: AppColor.primaryColor,
                  labelText: "phone".tr().toUpperCase(),
                  hintText: "Contact Phone number".tr(),
                  keyboardType: TextInputType.phone,
                  tec: widget.recipientPhoneTEC,
                  formValidator: (value) => FormValidator.validatePhone(
                    value,
                    name: "phone".tr().allWordsCapitilize(),
                  ),
                ),
                UiSpacer.formVerticalSpace(),
                //note
                ParcelFormInput(
                  isReadOnly: false,
                  iconData: FlutterIcons.note_oct,
                  iconColor: AppColor.primaryColor,
                  labelText: "Note".tr().toUpperCase(),
                  hintText: "Further instruction".tr(),
                  tec: widget.noteTEC,
                ),
              ],
            )),
      ],
    ).p12().box.p12.py4.border(color: AppColor.primaryColor).roundedSM.make();
  }

  _openContactPicker() async {
    bool granted = true;
    if (!(await FlutterContactPicker.hasPermission())) {
      granted = false;
      granted = await FlutterContactPicker.requestPermission();
    }

    if (granted) {
      final PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact();

      //
      setState(() {
        widget.recipientNameTEC.text = contact?.fullName;
        widget.recipientPhoneTEC.text = contact?.phoneNumber?.number?.removeAllWhiteSpace();
      });
    } else {
      Fluttertoast.showToast(
        msg: "Permission Denied".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
