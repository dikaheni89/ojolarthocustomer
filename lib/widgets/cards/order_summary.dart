import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/constants/rupiah.dart';
import 'package:fuodz/extensions/dynamic.dart';
import 'package:fuodz/extensions/string.dart';
import 'package:fuodz/views/pages/cart/widgets/amount_tile.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    this.subTotal,
    this.discount,
    this.deliveryFee,
    this.tax,
    this.vendorTax,
    this.total,
    this.driverTip = 0.00,
    this.mCurrencySymbol,
    Key key,
  }) : super(key: key);

  final double subTotal;
  final double discount;
  final double deliveryFee;
  final double tax;
  final String vendorTax;
  final double total;
  final double driverTip;
  final String mCurrencySymbol;
  @override
  Widget build(BuildContext context) {
    print("Test Discount");
    print(discount);
    final currencySymbol =
        mCurrencySymbol != null ? mCurrencySymbol : AppStrings.currencySymbol;
    return VStack(
      [
        "Order Summary".tr().text.semiBold.xl.make().pOnly(bottom: Vx.dp12),
        AmountTile("Subtotal".tr(), (subTotal ?? 0).currencyValueFormat())
            .py2(),
        // AmountTile(
        //   "Discount".tr(),
        //   "- " + "$currencySymbol ${discount ?? 0}".currencyFormat(currencySymbol),
        // ).py2(),
        AmountTile(
          "Discount".tr(),
          "- " + rupiah(discount ?? 0),
        ).py2(),
        // AmountTile(
        //   "Delivery Fee".tr(),
        //   "+ " + "$currencySymbol ${deliveryFee ?? 0}".currencyFormat(currencySymbol),
        // ).py2(),
        AmountTile(
          "Delivery Fee".tr(),
          "+ " + (deliveryFee ?? 0).currencyValueFormat(),
        ).py2(),
        // AmountTile(
        //   "Tax (%s)".tr().fill(["${vendorTax ?? 0}%"]),
        //   "+ " + " $currencySymbol ${tax ?? 0}".currencyFormat(currencySymbol),
        // ).py2(),
        AmountTile(
          "Tax (%s)".tr().fill(["${vendorTax ?? 0}%"]),
          "+ " + rupiah(tax ?? 0),
        ).py2(),
        DottedLine(dashColor: context.textTheme.bodyText1.color).py8(),
        Visibility(
          visible: driverTip != null && driverTip > 0,
          child: VStack(
            [
              // AmountTile(
              //   "Driver Tip".tr(),
              //   "+ " + "$currencySymbol ${driverTip ?? 0}".currencyFormat(currencySymbol),
              // ).py2(),
              AmountTile(
                "Driver Tip".tr(),
                "+ " + rupiah(driverTip ?? 0),
              ).py2(),
              DottedLine(dashColor: context.textTheme.bodyText1.color).py8(),
            ],
          ),
        ),
        AmountTile("Total Amount".tr(), (total ?? 0).currencyValueFormat()
            // "$currencySymbol ${total ?? 0}"
            //     .currencyFormat(currencySymbol),
            ),
      ],
    );
  }
}
