import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/extensions/dynamic.dart';
import 'package:fuodz/extensions/string.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/utils/utils.dart';
import 'package:fuodz/views/pages/cart/widgets/amount_tile.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class MultipleVendorOrderSummary extends StatelessWidget {
  const MultipleVendorOrderSummary({
    this.subTotal,
    this.discount,
    this.deliveryFee,
    this.tax,
    this.vendorTax,
    this.total,
    this.driverTip = 0.00,
    this.mCurrencySymbol,
    this.taxes,
    this.vendors,
    this.subtotals,
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
  final List<dynamic> taxes;
  final List<dynamic> vendors;
  final List<double> subtotals;
  @override
  Widget build(BuildContext context) {
    final currencySymbol =
        mCurrencySymbol != null ? mCurrencySymbol : AppStrings.currencySymbol;
    return VStack(
      [
        "Order Summary".tr().text.semiBold.xl.make().pOnly(bottom: Vx.dp12),
        AmountTile("Subtotal".tr(), (subTotal ?? 0).currencyValueFormat())
            .py2(),
        AmountTile(
          "Discount".tr(),
          "- " + "$currencySymbol ${discount ?? 0}".currencyFormat(),
        ).py2(),
        AmountTile(
          "Delivery Fee".tr(),
          "+ " + "$currencySymbol ${deliveryFee ?? 0}".currencyFormat(),
        ).py2(),
        //
        "Note: Delivery fee for each vendor is sum up to get the total delivery fee"
            .tr()
            .text
            .sm
            .coolGray600
            .italic
            .make(),
        DottedLine(dashColor: context.textTheme.bodyText1.color).py8(),
        AmountTile(
          "Tax".tr(),
          "+ " + " $currencySymbol ${tax ?? 0}".currencyFormat(),
        ).py2(),
        //taxes summary
        ...vendorTaxes(context, taxes, vendors, subtotals),

        DottedLine(dashColor: context.textTheme.bodyText1.color).py8(),
        Visibility(
          visible: driverTip != null && driverTip > 0,
          child: VStack(
            [
              AmountTile(
                "Driver Tip".tr(),
                "+ " + "$currencySymbol ${driverTip ?? 0}".currencyFormat(),
              ).py2(),
              DottedLine(dashColor: context.textTheme.bodyText1.color).py8(),
            ],
          ),
        ),
        AmountTile(
          "Total Amount".tr(),
          "$currencySymbol ${total ?? 0}".currencyFormat(),
        ),
      ],
    );
  }

  List<Widget> vendorTaxes(
    BuildContext context,
    List<dynamic> taxes,
    List<dynamic> vendors,
    List<double> subtotals,
  ) {
    final currencySymbol =
        mCurrencySymbol != null ? mCurrencySymbol : AppStrings.currencySymbol;
    List<Widget> items = [];
    for (var i = 0; i < taxes.length; i++) {
      final vendor = vendors[i] as Vendor;

      Widget widget = VStack(
        [
          "${vendor.name}".text.make(),
          HStack(
            [
              //
              "Subtotal".tr().text.sm.make().expand(),
              UiSpacer.horizontalSpace(),
              " $currencySymbol ${subtotals[i] ?? 0}"
                  .currencyFormat()
                  .text
                  .bold
                  .sm
                  .make(),
            ],
          ),
          HStack(
            [
              //
              "Tax (%s)".tr().fill(["${vendor.tax}%"]).text.sm.make().expand(),
              UiSpacer.horizontalSpace(),
              " $currencySymbol ${taxes[i] ?? 0}"
                  .currencyFormat()
                  .text
                  .semiBold
                  .sm
                  .make(),
            ],
          ),
        ],
      ).box.p8.border(color: Utils.textColorByTheme()).roundedSM.make().py2();
      items.add(widget);
    }
    return items;
  }
}
