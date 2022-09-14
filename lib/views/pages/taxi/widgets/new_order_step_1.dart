import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/taxi.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/cards/custom.visibility.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:measure_size/measure_size.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:date_time_picker/date_time_picker.dart';

class NewTaxiOrderStep1 extends StatelessWidget {
  const NewTaxiOrderStep1(this.vm, {Key key}) : super(key: key);
  final TaxiViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: Vx.dp20,
      left: Vx.dp20,
      right: Vx.dp20,
      child: MeasureSize(
        onChange: (size) {
          vm.updateGoogleMapPadding(height: size.height + Vx.dp20 + Vx.dp20);
        },
        child: vm.isBusy
            ? BusyIndicator().centered()
            : VStack(
                [
                  //
                  "Where to?".tr().text.medium.xl2.make(),
                  UiSpacer.verticalSpace(),
                  //from
                  CustomTextFormField(
                    textEditingController: vm.pickupLocationTEC,
                    hintText: "Pickup Location".tr(),
                    isReadOnly: true,
                    maxLines: 1,
                    prefixIcon: Icon(
                      FlutterIcons.circle_double_mco,
                      size: 16,
                      color: AppColor.getStausColor("pending"),
                    ),
                    onTap: () => vm.openLocationSelector(1),
                  ),
                  UiSpacer.verticalSpace(),
                  CustomTextFormField(
                    textEditingController: vm.dropoffLocationTEC,
                    hintText: "Drop-off Location".tr(),
                    isReadOnly: true,
                    maxLines: 1,
                    prefixIcon: Icon(
                      FlutterIcons.stop_circle_fea,
                      size: 16,
                      color: AppColor.getStausColor("delivered"),
                    ),
                    onTap: () => vm.openLocationSelector(2),
                  ),
                  UiSpacer.verticalSpace(),
                  CustomVisibilty(
                    visible: AppStrings.canScheduleTaxiOrder ?? false,
                    child: VStack(
                      [
                        //show schedule checkbox
                        HStack(
                          [
                            "Schedule Order".tr().text.make().expand(),
                            UiSpacer.horizontalSpace(),
                            Checkbox(
                              value: vm.canScheduleTaxiOrder,
                              onChanged: vm.toggleScheduleTaxiOrder,
                            ),
                          ],
                        ).onTap(() {
                          vm.toggleScheduleTaxiOrder(!vm.canScheduleTaxiOrder);
                        }),
                        //
                        CustomVisibilty(
                          visible: vm.canScheduleTaxiOrder,
                          child: HStack(
                            [
                              //
                              DateTimePicker(
                                type: DateTimePickerType.date,
                                initialValue: vm.checkout?.pickupDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  AppStrings.taxiMaxScheduleDays.toInt().days,
                                ),
                                dateLabelText: 'Date'.tr(),
                                onChanged: (val) {
                                  vm.checkout.pickupDate = val;
                                },
                                validator: (val) {
                                  return null;
                                },
                                onSaved: (val) => print(val),
                              ).expand(),
                              UiSpacer.horizontalSpace(),
                              //
                              DateTimePicker(
                                type: DateTimePickerType.time,
                                initialValue: vm.checkout?.pickupTime,
                                initialTime: TimeOfDay.fromDateTime(
                                    DateTime.now().add(30.minutes)),
                                firstDate: DateTime.now().add(30.minutes),
                                timeLabelText: 'Time'.tr(),
                                onChanged: (val) {
                                  vm.checkout.pickupTime = val;
                                },
                                validator: (val) {
                                  return null;
                                },
                                onSaved: (val) => print(val),
                              ).expand(),
                            ],
                          ),
                        ),
                      ],
                    ).pOnly(bottom: Vx.dp20),
                  ),
                  SafeArea(
                    top: false,
                    child: CustomButton(
                      child: "Next".tr().text.makeCentered(),
                      onPressed: vm.proceedToStep2,
                    ).wFull(context),
                  ),
                ],
              )
                .p20()
                .box
                .color(context.backgroundColor)
                .roundedSM
                .outerShadow2Xl
                .make(),
      ),
    );
  }
}
