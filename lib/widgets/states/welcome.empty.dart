import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/home_screen.config.dart';
import 'package:fuodz/models/user.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/navigation.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/utils/utils.dart';
import 'package:fuodz/view_models/welcome.vm.dart';
import 'package:fuodz/views/pages/pascabayar/PascabayarScreen.dart';
import 'package:fuodz/views/pages/prabayar/prabayarscreen.dart';
import 'package:fuodz/views/pages/vendor/widgets/banners.view.dart';
import 'package:fuodz/widgets/cards/custom.visibility.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/finance/wallet_management.view.dart';
import 'package:fuodz/widgets/list_items/vendor_type.list_item.dart';
import 'package:fuodz/widgets/list_items/vendor_type.vertical_list_item.dart';
import 'package:fuodz/widgets/states/loading.shimmer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../view_models/vendor/categories.vm.dart';

class EmptyWelcome extends StatelessWidget {
  const EmptyWelcome({this.vm, Key key}) : super(key: key);

  final WelcomeViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: vm.genKey,
      fit: StackFit.expand,
      children: [
        VxBox(
          child: SafeArea(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: !Utils.isArabic
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: VStack(
                [
                  //welcome intro and loggedin account name
                  StreamBuilder(
                    stream: AuthServices.listenToAuthState(),
                    builder: (ctx, snapshot) {
                      //
                      String introText = "Welcome".tr();
                      String fullIntroText = introText;
                      //
                      if (snapshot.hasData) {
                        return FutureBuilder<User>(
                            future: AuthServices.getCurrentUser(),
                            builder: (ctx, snapshot) {
                              if (snapshot.hasData) {
                                fullIntroText =
                                "$introText ${snapshot.data.name}";
                              }
                              return fullIntroText.text.white.xl3.semiBold
                                  .make();
                            });
                      }
                      return fullIntroText.text.white.xl3.semiBold.make();
                    },
                  ),
                  //

                  "How can I help you today?".tr().text.white.xl.medium.make(),
                  UiSpacer.verticalSpace(),
                ],
              ).py12(),
            ),
          ),
        ).color(AppColor.primaryColor).p20.make().wFull(context).positioned(
          height: (context.percentHeight * 22),
          left: 0,
          right: 0,
          top: 0,
        ),

        //
        VStack(
          [
            //finance section
            CustomVisibilty(
              visible: HomeScreenConfig.showWalletOnHomeScreen ?? true,
              child: WalletManagementView().px20(),
            ),
            //
            VStack(
              [
                HStack(
                  [
                    "Categories".tr().text.xl.medium.make().expand(),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                ).py4(),
                //list view
                CustomVisibilty(
                  visible: (HomeScreenConfig.isVendorTypeListingBoth &&
                      !vm.showGrid) ||
                      (!HomeScreenConfig.isVendorTypeListingBoth &&
                          HomeScreenConfig.isVendorTypeListingListView),
                  child: CustomListView(
                    noScrollPhysics: false,
                    dataSet: vm.vendorTypes,
                    isLoading: vm.isBusy,

                    loadingWidget: LoadingShimmer().px20(),
                    itemBuilder: (context, index) {
                      final vendorType = vm.vendorTypes[index];
                      return VendorTypeListItem(
                        vendorType,
                        onPressed: () {
                          print("Test");
                          NavigationService.pageSelected(vendorType,
                              context: context);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => UiSpacer.emptySpace(),
                  ),
                ),

                //gridview
                CustomVisibilty(
                  visible: HomeScreenConfig.isVendorTypeListingGridView &&
                      vm.showGrid &&
                      vm.isBusy,
                  child: LoadingShimmer().px20().centered(),
                ),

                Container(
                    height: 120,
                    child:ListView(
                      scrollDirection: Axis.horizontal,
                      children: vm.vendorTypes.map((item){
                        return InkWell(
                            onTap: (){
                              NavigationService.pageSelected(item,
                                  context: context);
                            },
                            child: Container(
                              // color: Colors.whi,
                                height: 120, width:100,
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: AppColor.onboarding1Color,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl:  item.logo,
                                          fit: BoxFit.cover,
                                          width: 45,
                                          height: 45,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Text(
                                      item.name.tr(),
                                      style: TextStyle(
                                          fontSize: 14
                                      ),
                                    )

                                  ],
                                )
                            )
                        );
                      }).toList(),
                    )
                )

              ],
            ).pLTRB(20, 20, 20, 0),

            VStack(
              [
                HStack(
                  [
                    "Prabayar".tr().text.xl.medium.make().expand(),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                ).py4(),
                //list view
                CustomVisibilty(
                  visible: (HomeScreenConfig.isVendorTypeListingBoth &&
                      !vm.showGrid) ||
                      (!HomeScreenConfig.isVendorTypeListingBoth &&
                          HomeScreenConfig.isVendorTypeListingListView),
                  child: CustomListView(
                    noScrollPhysics: false,
                    dataSet: vm.vendorTypes,
                    isLoading: vm.isBusy,

                    loadingWidget: LoadingShimmer().px20(),
                    itemBuilder: (context, index) {
                      final vendorType = vm.vendorTypes[index];
                      return VendorTypeListItem(
                        vendorType,
                        onPressed: () {
                          print("Test");
                          NavigationService.pageSelected(vendorType,
                              context: context);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => UiSpacer.emptySpace(),
                  ),
                ),

                //gridview
                CustomVisibilty(
                  visible: HomeScreenConfig.isVendorTypeListingGridView &&
                      vm.showGrid &&
                      vm.isBusy,
                  child: LoadingShimmer().px20().centered(),
                ),

                Container(
                    height: 130,
                    child:ListView(
                      scrollDirection: Axis.horizontal,
                      children: vm.listCatPrabayar.map((item){

                        return InkWell(
                            onTap: (){
                              // if()
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PrabayarScreen(
                                  nama: item.productName,
                                  categoryID: item.productId,
                                  urlGambar: item.gambarfix,
                                )),
                              );
                              // NavigationService.pageSelected(item,
                              //     context: context);
                            },
                            child: Container(
                              // color: Colors.whi,
                                height: 130, width:100,
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: AppColor.onboarding1Color,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl:  item.gambarfix,
                                          fit: BoxFit.cover,
                                          width: 45,
                                          height: 45,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Text(
                                      item.productName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14
                                      ),
                                    )

                                  ],
                                )
                            )
                        );
                      }).toList(),
                    )
                )

              ],
            ).pLTRB(20, 0, 20, 5),

            VStack(
              [
                HStack(
                  [
                    "Pascabayar".tr().text.xl.medium.make().expand(),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                ).py4(),
                //list view
                CustomVisibilty(
                  visible: (HomeScreenConfig.isVendorTypeListingBoth &&
                      !vm.showGrid) ||
                      (!HomeScreenConfig.isVendorTypeListingBoth &&
                          HomeScreenConfig.isVendorTypeListingListView),
                  child: CustomListView(
                    noScrollPhysics: false,
                    dataSet: vm.vendorTypes,
                    isLoading: vm.isBusy,

                    loadingWidget: LoadingShimmer().px20(),
                    itemBuilder: (context, index) {
                      final vendorType = vm.vendorTypes[index];
                      return VendorTypeListItem(
                        vendorType,
                        onPressed: () {
                          print("Test");
                          NavigationService.pageSelected(vendorType,
                              context: context);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => UiSpacer.emptySpace(),
                  ),
                ),

                //gridview
                CustomVisibilty(
                  visible: HomeScreenConfig.isVendorTypeListingGridView &&
                      vm.showGrid &&
                      vm.isBusy,
                  child: LoadingShimmer().px20().centered(),
                ),

                Container(
                    height: 130,
                    child:ListView(
                      scrollDirection: Axis.horizontal,
                      children: vm.listCatPascabayar.map((item){

                        return InkWell(
                            onTap: (){
                              // if()
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PascabayarScreen(
                                  nama: item.productName,
                                  categoryID: item.productId,
                                  urlGambar: item.gambarfix,
                                )),
                              );
                            },
                            child: Container(
                              // color: Colors.whi,
                                height: 130, width:100,
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: AppColor.onboarding1Color,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl:  item.gambarfix,
                                          fit: BoxFit.cover,
                                          width: 45,
                                          height: 45,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Text(
                                      item.productName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14
                                      ),
                                    )

                                  ],
                                )
                            )
                        );
                      }).toList(),
                    )
                )

              ],
            ).pLTRB(20, 0, 20, 5),

            HStack(
              [
                Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("Spesial Promo",
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                )

              ],
              crossAlignment: CrossAxisAlignment.center,
            ).py4(),

            //top banner
            CustomVisibilty(
              visible: HomeScreenConfig.showBannerOnHomeScreen &&
                  HomeScreenConfig.isBannerPositionTop,
              child: VStack(
                [
                  // UiSpacer.verticalSpace(),
                  Banners(
                    null,
                    featured: true,
                  ).py12(),
                ],
              ),
            ),

            //botton banner
            CustomVisibilty(
              visible: HomeScreenConfig.showBannerOnHomeScreen &&
                  !HomeScreenConfig.isBannerPositionTop,
              child: Banners(
                null,
                featured: true,
              ).py12().pOnly(bottom: context.percentHeight * 10),
            ),
          ],
        )
            .scrollVertical()
            .box
            .color(context.backgroundColor)
            .topRounded(value: 25)
            .make()
            .positioned(
          top: (context.percentHeight * 22) - 30,
          left: 0,
          right: 0,
          bottom: 0,
        ),
      ],
    );
  }
}