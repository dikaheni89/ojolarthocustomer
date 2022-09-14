import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/taxi.vm.dart';
import 'package:fuodz/views/pages/service/widgets/service_discount_section.dart';
import 'package:fuodz/views/pages/taxi/widgets/order_taxi.button.dart';
import 'package:fuodz/views/pages/taxi/widgets/taxi_payment.item_view.dart';
import 'package:fuodz/widgets/buttons/custom_text_button.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/vehicle_type.list_item.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:measure_size/measure_size.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:velocity_x/velocity_x.dart';

class NewTaxiOrderStep2 extends StatelessWidget {
  const NewTaxiOrderStep2(this.vm, {Key key}) : super(key: key);
  final TaxiViewModel vm;
  @override
  Widget build(BuildContext context) {
    // print("Test");
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SlidingUpPanel(
        backdropColor: context.backgroundColor,
        minHeight: 480,
        maxHeight: context.percentHeight * 80,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        footer: OrderTaxiButton(vm),
        color: context.backgroundColor,
        panel: MeasureSize(
          onChange: (size) {
            vm.updateGoogleMapPadding(height: size.height + Vx.dp40);
          },
          child: VStack(
            [
              //
              UiSpacer.swipeIndicator(),
              //
              HStack(
                [
                  //previous
                  CustomTextButton(
                    padding: EdgeInsets.zero,
                    title: "Back".tr(),
                    onPressed: () => vm.closeOrderSummary(clear: false),
                  ),
                  UiSpacer.expandedSpace(),
                  //cancel book
                  CustomTextButton(
                    padding: EdgeInsets.zero,
                    title: "Cancel".tr(),
                    titleColor: Colors.red,
                    onPressed: vm.closeOrderSummary,
                  ),
                ],
              ),
              UiSpacer.verticalSpace(),
              //vehicle types
              CustomListView(
                scrollDirection: Axis.horizontal,
                dataSet: vm.vehicleTypes,
                isLoading: vm.busy(vm.vehicleTypes),
                itemBuilder: (context, index) {
                  //
                  final vehicleType = vm.vehicleTypes[index];
                  //
                  return VehicleTypeListItem(vm, vehicleType);
                },
              ).h(100),
              UiSpacer.verticalSpace(),
              //selected payment method
              "Payment".tr().text.semiBold.xl.make(),
              UiSpacer.verticalSpace(space: 5),
              CustomListView(
                scrollDirection: Axis.horizontal,
                dataSet: vm.paymentMethods,
                isLoading: vm.busy(vm.paymentMethods),
                itemBuilder: (context, index) {
                  final paymentMethod = vm.paymentMethods[index];
                  return TaxiPaymentItemView(
                    paymentMethod,
                    selected: (vm.selectedPaymentMethod != null) &&
                        (vm.selectedPaymentMethod.id == paymentMethod.id),
                    onselected: () {
                      vm.changeSelectedPaymentMethod(
                        paymentMethod,
                        callTotal: false,
                      );
                    },
                  );
                },
              ).h(60),
              UiSpacer.verticalSpace(),
              //discount section
              ServiceDiscountSection(vm, toggle: true),
              UiSpacer.verticalSpace(),
            ],
          ).p20(),
        ),
      ).pOnly(
        bottom: context.mq.viewInsets.bottom,
      ),
    );
  }
}
