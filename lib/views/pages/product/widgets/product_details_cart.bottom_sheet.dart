import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/extensions/string.dart';
import 'package:fuodz/view_models/product_details.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/currency_hstack.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailsCartBottomSheet extends StatelessWidget {
  const ProductDetailsCartBottomSheet({this.model, Key key}) : super(key: key);

  final ProductDetailsViewModel model;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        Visibility(
          visible: model.product.hasStock,
          child: HStack(
            [
              //
              "Quantity".tr().text.xl.medium.make().expand(),
              //
              VxStepper(
                defaultValue: model.product.selectedQty ?? 1,
                min: 1,
                max: (model.product.availableQty != null &&
                        model.product.availableQty > 0)
                    ? model.product.availableQty
                    : 20,
                disableInput: true,
                onChange: model.updatedSelectedQty,
              ),
            ],
          ),
        ),

        //
        Visibility(
          visible: model.product.hasStock,
          child: HStack(
            [
              //
              CustomButton(
                loading: model.isBusy,
                child: Icon(
                  FlutterIcons.heart_fea,
                  color: Colors.white,
                ),
                onPressed: !model.isAuthenticated()
                    ? model.openLogin
                    : !model.product.isFavourite
                        ? model.addToFavourite
                        : null,
              ).w(Vx.dp64).pOnly(right: Vx.dp24),
              //
              CustomButton(
                loading: model.isBusy,
                child: HStack(
                  [
                    "Add to cart".tr().text.white.medium.make().expand(),

                    CurrencyHStack(
                       [
                        model.currencySymbol.text.white.lg.make(),
                        model.total.currencyValueFormat().text.white
                            .letterSpacing(1.5)
                            .xl
                            .semiBold
                            .make(),
                      ],
                    ),
                  ],
                ).p12(),
                onPressed: model.addToCart,
              ).expand(),
            ],
          ).py12(),
        ),

        Visibility(
          visible: !model.product.hasStock,
          child: "No stock"
              .tr()
              .text
              .white
              .makeCentered()
              .p8()
              .box
              .red500
              .roundedSM
              .make()
              .p8()
              .wFull(context),
        ),
      ],
    ).p20().box.color(context.backgroundColor).shadowXl.make().wFull(context);
  }
}
