import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/extensions/dynamic.dart';
import 'package:fuodz/resources/resources.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/profile.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/cards/profile.card.dart';
import 'package:fuodz/widgets/menu_item.dart' as menu;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return BasePage(
            body: VStack(
              [
                //
                "Settings".tr().text.xl2.semiBold.make(),
                "Profile & App Settings".tr().text.lg.light.make(),

                //profile card
                ProfileCard(model).py12(),

                //menu
                VStack(
                  [
                    //
                    menu.MenuItem(
                      title: "Notifications".tr(),
                      onPressed: model.openNotification,
                      ic: AppIcons.bell,
                    ),

                    //
                    menu.MenuItem(
                      title: "Rate & Review".tr(),
                      onPressed: model.openReviewApp,
                      ic: AppIcons.rating,
                    ),

                    //
                    menu.MenuItem(
                      title: "Privacy Policy".tr(),
                      onPressed: model.openPrivacyPolicy,
                      ic: AppIcons.compliant,
                    ),
                    //
                    menu.MenuItem(
                      title: "Terms & Conditions".tr(),
                      onPressed: model.openTerms,
                      ic: AppIcons.termsAndConditions,
                    ),
                    //
                    menu.MenuItem(
                      title: "Contact Us".tr(),
                      onPressed: model.openContactUs,
                      ic: AppIcons.communicate,
                    ),
                    //
                    menu.MenuItem(
                      title: "Live Support".tr(),
                      onPressed: model.openLivesupport,
                      ic: AppIcons.livesupport,
                    ),
                    //
                    menu.MenuItem(
                      title: "Language".tr(),
                      divider: false,
                      ic: AppIcons.translation,
                      onPressed: model.changeLanguage,
                    ),

                    //
                    menu.MenuItem(
                      title: "Version".tr(),
                      suffix: model.appVersionInfo.text.make(),
                    ),
                  ],
                ),

                //
                "Copyright ©%s %s all right reserved"
                    .tr()
                    .fill([
                      "${DateTime.now().year}",
                      AppStrings.companyName,
                    ])
                    .text
                    .center
                    .sm
                    .makeCentered()
                    .py20(),
                //
                UiSpacer.verticalSpace(space: context.percentHeight * 10),
              ],
            ).p20().scrollVertical(),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
