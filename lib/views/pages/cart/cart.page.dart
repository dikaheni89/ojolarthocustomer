import 'package:flutter/material.dart';
import 'package:fuodz/extensions/string.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/cart.vm.dart';
import 'package:fuodz/views/pages/cart/widgets/amount_tile.dart';
import 'package:fuodz/views/pages/cart/widgets/apply_coupon.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/cart.list_item.dart';
import 'package:fuodz/widgets/states/cart.empty.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../../constants/rupiah.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      showLeadingAction: true,
      title: "My Cart".tr(),
      body: SafeArea(
        child: ViewModelBuilder<CartViewModel>.reactive(
          viewModelBuilder: () => CartViewModel(context),
          onModelReady: (model) => model.initialise(),
          builder: (context, model, child) {
            return VStack(
              [
                //
                if (model.cartItems.isEmpty)
                  EmptyCart().centered().expand()
                else
                  VStack(
                    [
                      //cart items list
                      UiSpacer.verticalSpace(),
                      CustomListView(
                        noScrollPhysics: true,
                        dataSet: model.cartItems,
                        itemBuilder: (context, index) {
                          //
                          final cart = model.cartItems[index];
                          return CartListItem(
                            cart,
                            onQuantityChange: (qty) =>
                                model.updateCartItemQuantity(qty, index),
                            deleteCartItem: () => model.deleteCartItem(index),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            UiSpacer.divider(height: 20),
                      ),

                      //
                      UiSpacer.divider(height: 20),
                      ApplyCoupon(model),
                      UiSpacer.verticalSpace(),
                      AmountTile(
                          "Total Item".tr(), model.totalCartItems.toString()),
                      AmountTile(
                          "Sub-Total".tr(),
                          rupiah(model.subTotalPrice)),
                          // "${model.currencySymbol} ${model.subTotalPrice}"
                          //     .currencyFormat()),
                      AmountTile(
                          "Discount".tr(),
                          rupiah(model.discountCartPrice)),
                          // "${model.currencySymbol} ${model.discountCartPrice}"
                          //     .currencyFormat()),
                      DottedLine(dashColor: context.textTheme.bodyText1.color)
                          .py12(),
                      AmountTile(
                          "Total".tr(),
                          rupiah(model.totalCartPrice)),
                          // "${model.currencySymbol} ${model.totalCartPrice}"
                          //     .currencyFormat()),
                      //
                      CustomButton(
                        title: "CHECKOUT".tr(),
                        onPressed: model.checkoutPressed,
                      ).h(Vx.dp48).py32(),
                    ],
                  )
                      .pOnly(bottom: context.mq.viewPadding.bottom)
                      .scrollVertical()
                      .expand(),
              ],
            ).p20();
          },
        ),
      ),
    );
  }
}
