import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/enums/product_fetch_data_type.enum.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor.vm.dart';
import 'package:fuodz/views/pages/vendor/widgets/banners.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/categories.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/header.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/section_products.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/section_vendors.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/cards/custom.visibility.dart';
import 'package:fuodz/widgets/cards/view_all_vendors.view.dart';
import 'package:fuodz/widgets/inputs/search_bar.input.dart';
import 'package:fuodz/widgets/list_items/food_horizontal_product.list_item.dart';
import 'package:fuodz/widgets/list_items/grid_view_product.list_item.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.list_item.dart';
import 'package:fuodz/widgets/list_items/horizontal_vendor.list_item.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class FoodPage extends StatefulWidget {
  const FoodPage(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage>
    with AutomaticKeepAliveClientMixin<FoodPage> {
  GlobalKey pageKey = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BasePage(
      showAppBar: true,
      showLeadingAction: !AppStrings.isSingleVendorMode,
      elevation: 0,
      title: "${widget.vendorType.name}",
      appBarColor: context.theme.backgroundColor,
      appBarItemColor: AppColor.primaryColor,
      showCart: true,
      key: pageKey,
      body: ViewModelBuilder<VendorViewModel>.reactive(
        viewModelBuilder: () => VendorViewModel(context, widget.vendorType),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return VStack(
            [
              //location setion
              VendorHeader(
                model: model,
                showSearch: false,
              ),

              SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: model.refreshController,
                onRefresh: () {
                  model.refreshController.refreshCompleted();
                  setState(() {
                    pageKey = GlobalKey<State>();
                  });
                },
                child: VStack(
                  [
                    //search bar
                    SearchBarInput(
                      hintText:
                          "Search for your desired foods or restaurants".tr(),
                      readOnly: true,
                      search: Search(
                        vendorType: widget.vendorType,
                        viewType: SearchType.vendorProducts,
                      ),
                    ).px12(),
                    UiSpacer.verticalSpace(),
              
                    //banners
                    Banners(
                      widget.vendorType,
                      viewportFraction: 0.96,
                    ),
              
                    //categories
                    Categories(
                      widget.vendorType,
                    ),
                    //popular vendors
                    SectionVendorsView(
                      widget.vendorType,
                      title: "Popular vendors".tr(),
                      scrollDirection: Axis.horizontal,
                      type: SearchFilterType.sales,
                      itemWidth: context.percentWidth * 60,
                      byLocation: AppStrings.enableFatchByLocation,
                    ),
                    //campain vendors
                    SectionProductsView(
                      widget.vendorType,
                      title: "Campaigns".tr(),
                      scrollDirection: Axis.horizontal,
                      type: ProductFetchDataType.FLASH,
                      itemWidth: context.percentWidth * 38,
                      viewType: GridViewProductListItem,
                      byLocation: AppStrings.enableFatchByLocation,
                    ),
                    //popular foods
                    SectionProductsView(
                      widget.vendorType,
                      title: "Popular Foods Nearby".tr(),
                      scrollDirection: Axis.horizontal,
                      type: ProductFetchDataType.BEST,
                      itemWidth: context.percentWidth * 70,
                      itemHeight: 120,
                      viewType: FoodHorizontalProductListItem,
                      listHeight: 115,
                      byLocation: AppStrings.enableFatchByLocation,
                    ),
                    //new vendors
                    CustomVisibilty(
                      visible: !AppStrings.enableSingleVendor,
                      child: SectionVendorsView(
                        widget.vendorType,
                        title: "New on".tr() + " ${AppStrings.appName}",
                        scrollDirection: Axis.horizontal,
                        type: SearchFilterType.fresh,
                        itemWidth: context.percentWidth * 60,
                         byLocation: AppStrings.enableFatchByLocation,
                      ),
                    ),
                    //all vendor
                    CustomVisibilty(
                      visible: !AppStrings.enableSingleVendor,
                      child: SectionVendorsView(
                        widget.vendorType,
                        title: "All Vendors/Restaurants".tr(),
                        scrollDirection: Axis.vertical,
                        type: SearchFilterType.best,
                        viewType: HorizontalVendorListItem,
                        separator: UiSpacer.verticalSpace(space: 0),
                      ),
                    ),
                    //all products
                    CustomVisibilty(
                      visible: AppStrings.enableSingleVendor,
                      child: SectionProductsView(
                        widget.vendorType,
                        title: "All Products".tr(),
                        scrollDirection: Axis.vertical,
                        type: ProductFetchDataType.BEST,
                        viewType: HorizontalProductListItem,
                        separator: UiSpacer.verticalSpace(space: 0),
                        listHeight: null,
                      ),
                    ),
                    //view all vendors
                    ViewAllVendorsView(
                      vendorType: widget.vendorType,
                    ),
                    UiSpacer.verticalSpace(),
                  ],
                  // key: model.pageKey,
                ).scrollVertical(),
              ).expand(),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
