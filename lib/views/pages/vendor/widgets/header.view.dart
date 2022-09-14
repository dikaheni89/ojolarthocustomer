import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/widgets/cards/custom.visibility.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorHeader extends StatefulWidget {
  const VendorHeader({
    Key key,
    this.model,
    this.showSearch = true,
  }) : super(key: key);

  final MyBaseViewModel model;
  final bool showSearch;

  @override
  _VendorHeaderState createState() => _VendorHeaderState();
}

class _VendorHeaderState extends State<VendorHeader> {
  @override
  void initState() {
    super.initState();
    //
    if (widget.model.deliveryaddress.address == "Current Location") {
      widget.model.fetchCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        HStack(
          [
            //location icon
            Icon(
              FlutterIcons.location_pin_sli,
              size: 24,
            ).onInkTap(
              widget.model.useUserLocation,
            ),

            //
            VStack(
              [
                //
                HStack(
                  [
                    //
                    "Delivery Location".tr().text.sm.semiBold.make(),
                    //
                    Icon(
                      FlutterIcons.chevron_down_fea,
                    ).px4(),
                  ],
                ),
                widget.model.deliveryaddress.address.text
                    .maxLines(1)
                    .ellipsis
                    .base
                    .make(),
              ],
            )
                .onInkTap(
                  widget.model.pickDeliveryAddress,
                )
                .px12()
                .expand(),
          ],
        ).expand(),

        //
        CustomVisibilty(
          visible: widget.showSearch,
          child: Icon(
            FlutterIcons.search_fea,
            size: 20,
          )
              .p8()
              .onInkTap(() {
                widget.model.openSearch();
              })
              .box
              .roundedSM
              .clip(Clip.antiAlias)
              .color(context.backgroundColor)
              .outerShadowSm
              .make(),
        ),
      ],
    )
        .p12()
        .box
        .color(context.backgroundColor)
        .bottomRounded()
        .outerShadowSm
        .make()
        .pOnly(bottom: Vx.dp20);
  }
}
