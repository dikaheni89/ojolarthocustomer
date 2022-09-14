import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/enums/product_fetch_data_type.enum.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/views/pages/commerce/widgets/commerce_categories_products.view.dart';
import 'package:fuodz/views/pages/commerce/widgets/products_section.view.dart';
import 'package:fuodz/views/pages/search/search.page.dart';
import 'package:fuodz/views/pages/vendor/widgets/banners.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/categories.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/inputs/search_bar.input.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class CommercePage extends StatefulWidget {
  const CommercePage(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;
  @override
  _CommercePageState createState() => _CommercePageState();
}

class _CommercePageState extends State<CommercePage>
    with AutomaticKeepAliveClientMixin<CommercePage> {
  @override
  bool get wantKeepAlive => true;

  GlobalKey pageKey = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BasePage(
      showAppBar: true,
      showLeadingAction: !AppStrings.isSingleVendorMode,
      elevation: 0,
      title: "${widget.vendorType.name}",
      appBarColor: AppColor.faintBgColor,
      appBarItemColor: AppColor.primaryColor,
      showCart: true,
      backgroundColor: AppColor.faintBgColor,
      key: pageKey,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: new RefreshController(),
        onRefresh: () {
          setState(() {
            pageKey = GlobalKey<State>();
          });
        },
        child: VStack(
          [
            //intro
            "Discover".tr().text.xl4.semiBold.make(),
            "Find anything that you want".tr().text.lg.thin.make(),
            UiSpacer.verticalSpace(),

            //search bar
            SearchBarInput(
              showFilter: false,
              onTap: () => showSearchPage(context),
            ),
            UiSpacer.verticalSpace(),

            VStack(
              [
                //banners
                Banners(widget.vendorType),
                //categories
                Categories(
                  widget.vendorType,
                ),
                
                UiSpacer.verticalSpace(),
                //Best sellers
                ProductsSectionView(
                  "Flash Sales".tr() + " ⏳",
                  vendorType: widget.vendorType,
                  type: ProductFetchDataType.FLASH,
                ),
                UiSpacer.verticalSpace(),
                //new arrivals
                ProductsSectionView(
                  "New Arrivals".tr() + " 🛬",
                  vendorType: widget.vendorType,
                  type: ProductFetchDataType.NEW,
                ),
                UiSpacer.verticalSpace(),
                //Best sellers
                ProductsSectionView(
                  "Best Selling".tr() + " 📊",
                  vendorType: widget.vendorType,
                  type: ProductFetchDataType.BEST,
                ),
                UiSpacer.verticalSpace(),
                //top 7 categories products
                CommerceCategoryProducts(widget.vendorType, length: 5),
              ],
            ),
          ],
          // key: model.pageKey,
        ).scrollVertical(padding: EdgeInsets.all(20)),
      ),
    );
  }

  //open search page
  showSearchPage(BuildContext context) {
    final search = Search(
      showType: 4,
      vendorType: widget.vendorType,
    );
    //
    context.push(
      (context) => SearchPage(
        search: search,
      ),
    );
  }
}
