import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class ComplexVendorHeader extends StatelessWidget {
  const ComplexVendorHeader({
    Key key,
    this.model,
    this.searchShowType,
  }) : super(key: key);

  final MyBaseViewModel model;
  final int searchShowType;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //location icon
        Icon(
          FlutterIcons.location_pin_sli,
          size: 24,
        ).onInkTap(
          model.useUserLocation,
        ),

        //
        VStack(
          [
            //
            "Delivery Location".tr().text.lg.semiBold.make(),
            model.deliveryaddress.address.text.base.maxLines(1).make(),
          ],
        )
            .onInkTap(
              model.pickDeliveryAddress,
            )
            .px12()
            .expand(),

        //
        //
        Icon(
          FlutterIcons.search_fea,
          size: 24,
        )
            .p8()
            .onInkTap(() {
              model.openSearch(showType: searchShowType ?? 4);
            })
            .box
            .roundedSM
            .clip(Clip.antiAlias)
            .color(context.backgroundColor)
            .shadowXs
            .make(),
      ],
    ).p8().px16().py8();
  }
}
