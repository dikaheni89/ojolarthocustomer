import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/models/customcategories.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/requests/category.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/preference.dart';
import '../../database/database_helper.dart';
import '../../database/tables/home_plan_table.dart';
import '../../utils/utils.dart';

class CategoriesViewModel extends MyBaseViewModel {
  CategoriesViewModel(BuildContext context, {this.vendorType}) {
    this.viewContext = context;
  }
  List<HomePlanTable> allPlanDataList = [];
  int totalQuarantineWorkout = 0;
  int totalWorkout = 0;
  double totalKcal = 0.0;
  int totalMin = 0;
  List<bool> isAvailableHistory = [];
  int dayInRow = 0;
  String progress = "";
  int intProgress = 0;
  String leftDays = "";
  String selectedTrainingDay = "0";
  int selectedFirstDayOfWeek = 0;
  int totalDayOfWeekGoal = 0;

  //
  CategoryRequest _categoryRequest = CategoryRequest();
  CustomCategories customCategories;
  RefreshController refreshController = RefreshController();

  //
  List<Category> categories = [];
  final VendorType vendorType;
  int queryPage = 1;

  //
  initialise({bool all = false}) async {
    setBusy(true);
    try {
      if(vendorType.slug == "pharmacy"){
        await getPreference();
        await getDataFromDatabase();
        print("Done init DB");
        await getSubCategory(vendorType.id.toString());
      }else{
        categories = await _categoryRequest.categories(
          vendorTypeId: vendorType.id,
          page: queryPage,
          full: all ? 1 : 0,
        );

      }

      clearErrors();

    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  //
  loadMoreItems([bool initialLoading = false, bool all = true]) async {
    if (initialLoading) {
      setBusy(true);
      queryPage = 1;
      refreshController.refreshCompleted();
    } else {
      queryPage += 1;
    }
    //
    try {
      final mCategories = await _categoryRequest.categories(
        vendorTypeId: vendorType.id,
        page: queryPage,
        full: all ? 1 : 0,
      );
      clearErrors();

      //
      if (initialLoading) {
        categories = mCategories;
      } else {
        categories.addAll(mCategories);
      }
    } catch (error) {
      setError(error);
    }
    if (initialLoading) {
      setBusy(false);
    }
    refreshController.loadComplete();
    notifyListeners();
  }

  //
  categorySelected(Category category) async {
    viewContext.navigator.pushNamed(
      AppRoutes.search,
      arguments: Search(
        vendorType: category.vendorType,
        category: category,
        showType: (category.vendorType.isService ?? false) ? 5 : 4,
      ),
    );
  }

  getSubCategory(String vendor_type_id) async {
    customCategories = await _categoryRequest.getSubCategories(
      vendor_type_id: vendor_type_id,
    );
    // notifyListeners();
  }

  getDataFromDatabase() async {
    await _getAllPlanList();
    await _getTotalQuarantineWorkout();
    await _getTotalWorkoutDetail();
    await _getTotalQuarantineWorkout();
    await _getHistoryWeekWise();
  }

  getPreference() {
    selectedFirstDayOfWeek =
        Preference.shared.getInt(Preference.SELECTED_FIRST_DAY_OF_WEEK) ?? 0;
    selectedTrainingDay =
        Preference.shared.getString(Preference.SELECTED_TRAINING_DAY) ?? "0";
  }

  _getTotalWorkoutDetail() async {
    // totalWorkout = await DataBaseHelper().getHistoryTotalWorkout() ?? 0;
    // totalKcal = await DataBaseHelper().getHistoryTotalKCal() ?? 0;
    // totalMin = await DataBaseHelper().getHistoryTotalMinutes() ?? 0;
    // totalMin = totalMin ~/ 60;
    // setState(() {});
    notifyListeners();
  }

  _getAllPlanList() async {
    allPlanDataList = await DataBaseHelper().getHomePlanData();
    var data = {
      "data" : allPlanDataList,
    };
    print(jsonEncode(data));

    print(allPlanDataList.length);

    notifyListeners();
  }

  _getTotalQuarantineWorkout() async {
    totalQuarantineWorkout =
    await DataBaseHelper().getTotalWorkoutQuarantineAtHome();
    notifyListeners();
    // setState(() {});
  }

  _getHistoryWeekWise() {
    int tempInt = 0;
    Utils.getDaysDateForHistoryOfWeek().forEach((element) async {
      bool isAvailable =
      await DataBaseHelper().isHistoryAvailableDateWise(element.toString());
      isAvailableHistory.add(isAvailable);
      if (isAvailable) {
        tempInt = tempInt + 1;
        if (int.parse(selectedTrainingDay) >= tempInt) {
          totalDayOfWeekGoal = totalDayOfWeekGoal + 1;
        }
      }
    });
    isAvailableHistory.forEach((element) {});
    // setState(() {});
  }

}
