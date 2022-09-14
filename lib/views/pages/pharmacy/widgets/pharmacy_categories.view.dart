// import 'package:flutter/material.dart';
// import 'package:fuodz/constants/app_strings.dart';
// import 'package:fuodz/models/vendor_type.dart';
// import 'package:fuodz/view_models/vendor/categories.vm.dart';
// import 'package:fuodz/widgets/vendor_type_categories.view.dart';
// import 'package:intl/intl.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:stacked/stacked.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// import '../../../../constants/constant.dart';
// import '../../../../constants/localization/language/languages.dart';
// import '../../../../constants/preference.dart';
// import '../../../../database/database_helper.dart';
// import '../../../../database/tables/fullbody_workout_table.dart';
// import '../../../../utils/color.dart';
// import '../../../../utils/utils.dart';
// import '../gym/exerciseDays/exercise_days_status_screen.dart';
//
// class PharmacyCategories extends StatefulWidget {
//   const PharmacyCategories(this.vendorType, {Key key}) : super(key: key);
//
//   final VendorType vendorType;
//   @override
//   _PharmacyCategoriesState createState() => _PharmacyCategoriesState();
// }
//
// class _PharmacyCategoriesState extends State<PharmacyCategories> {
//   bool isOpen = false;
//   ScrollController _scrollController;
//   bool lastStatus = true;
//
//   @override
//   void initState() {
//     // _manageDrawer();
//     // _createNativeAd();
//     // InAppPurchaseHelper().getAlreadyPurchaseItems(this);
//     Preference.shared.setInt(Preference.DRAWER_INDEX, 0);
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//     // _createBottomBannerAd();
//     super.initState();
//   }
//
//   _scrollListener() {
//     if (isShrink != lastStatus) {
//       setState(() {
//         lastStatus = isShrink;
//       });
//     }
//   }
//   bool get isShrink {
//     return _scrollController.hasClients &&
//         _scrollController.offset > (200 - kToolbarHeight);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<CategoriesViewModel>.reactive(
//       viewModelBuilder: () =>
//           CategoriesViewModel(context, vendorType: widget.vendorType),
//       onModelReady: (model) => model.initialise(),
//       builder: (context, model, child) {
//         return VStack(
//           [
//             //categories
//             Container(
//                 height: MediaQuery.of(context).size.height,
//                 child: NestedScrollView(
//                   headerSliverBuilder:
//                       (BuildContext context, bool innerBoxIsScrolled) {
//                     return <Widget>[
//                       SliverAppBar(
//                         elevation: 2,
//                         expandedHeight:280.0,
//                         // (selectedTrainingDay == "0") ? 280.0 : 250.0,
//                         floating: false,
//                         pinned: true,
//                         titleSpacing: -5,
//
//                         backgroundColor: Colors.white,
//                         centerTitle: false,
//                         flexibleSpace: FlexibleSpaceBar(
//                           centerTitle: true,
//                           background: Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image:
//                                     AssetImage("assets/images/main_bg.webp"),
//                                     fit: BoxFit.cover)),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Container(
//                                   height: 250,
//                                   child: Stack(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           Container(
//                                             height: 180,
//                                             child: Container(
//                                               margin: EdgeInsets.only(
//                                                 // top:30),
//                                                   top:(model.selectedTrainingDay == "0")
//                                                       ? 30
//                                                       : 60),
//                                               child: InkWell(
//                                                 onTap: () {
//
//                                                   // Navigator.push(
//                                                   //     context,
//                                                   //     MaterialPageRoute(
//                                                   //         builder: (context) =>
//                                                   //             WorkoutHistoryScreen(
//                                                   //               isFromTraining:
//                                                   //               true,
//                                                   //             )));
//                                                 },
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceEvenly,
//                                                   children: [
//                                                     Column(
//                                                       children: [
//                                                         Text(
//                                                           // "0",
//                                                             (model.totalWorkout != 0)
//                                                                 ? model.totalWorkout
//                                                                 .toString()
//                                                                 : "0",
//                                                             overflow: TextOverflow
//                                                                 .ellipsis,
//                                                             style: TextStyle(
//                                                                 color: Colors.white,
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .w500)),
//                                                         Text(
//                                                             Languages.of(context)
//                                                                 .txtExercises
//                                                                 .toUpperCase(),
//                                                             overflow: TextOverflow
//                                                                 .ellipsis,
//                                                             style: TextStyle(
//                                                                 color: Colors.white
//                                                                     .withOpacity(
//                                                                     0.6),
//                                                                 fontSize: 14,
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .w500)),
//                                                       ],
//                                                     ),
//                                                     Column(
//                                                       children: [
//                                                         Text(
//                                                           // "0",
//                                                             (model.totalKcal != 0)
//                                                                 ? model.totalKcal
//                                                                 .toString()
//                                                                 : "0",
//                                                             overflow: TextOverflow
//                                                                 .ellipsis,
//                                                             style: TextStyle(
//                                                                 color:
//                                                                 Colors.white,
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .w500)),
//                                                         Text(
//                                                             Languages.of(context)
//                                                                 .txtKcal
//                                                                 .toUpperCase(),
//                                                             overflow: TextOverflow
//                                                                 .ellipsis,
//                                                             style: TextStyle(
//                                                                 color: Colors.white
//                                                                     .withOpacity(
//                                                                     0.6),
//                                                                 fontSize: 14,
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .w500)),
//                                                       ],
//                                                     ),
//                                                     Column(
//                                                       children: [
//                                                         Text(
//                                                           // "0",
//                                                             (model.totalMin != 0)
//                                                                 ? model.totalMin
//                                                                 .toString()
//                                                                 : "0",
//                                                             overflow: TextOverflow
//                                                                 .ellipsis,
//                                                             style: const TextStyle(
//                                                                 color:
//                                                                 Colors.white,
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .w500)),
//                                                         Text(
//                                                             Languages.of(context)
//                                                                 .txtMinute
//                                                                 .toUpperCase(),
//                                                             overflow: TextOverflow
//                                                                 .ellipsis,
//                                                             style: TextStyle(
//                                                                 color: Colors.white
//                                                                     .withOpacity(
//                                                                     0.6),
//                                                                 fontSize: 14,
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .w500)),
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 70,
//                                             color: Colors.grey,
//                                           ),
//                                         ],
//                                       ),
//                                       Container(
//                                           margin: EdgeInsets.only(
//                                               top:90,
//                                               // top: (selectedTrainingDay == "0")
//                                               //     ? 90.0
//                                               //     : 120.0,
//                                               right: 20,
//                                               left: 20,
//                                               bottom: 10),
//                                           decoration: const BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(10)),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black38,
//                                                 offset: Offset(0.0, 1.0),
//                                                 blurRadius: 5.0,
//                                               ),
//                                             ],
//                                           ),
//                                           child: (model.selectedTrainingDay == "0")
//                                               ? Column(
//                                             children: [
//                                               Container(
//                                                 alignment:
//                                                 Alignment.topLeft,
//                                                 margin:
//                                                 const EdgeInsets.all(
//                                                     10),
//                                                 child: Text(
//                                                     Languages.of(context)
//                                                         .txtWeekGoal
//                                                         .toUpperCase(),
//                                                     overflow: TextOverflow
//                                                         .ellipsis,
//                                                     style: const TextStyle(
//                                                         color: Colur.black,
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .w500)),
//                                               ),
//                                               Container(
//                                                 margin:
//                                                 const EdgeInsets.only(
//                                                     top: 10),
//                                                 child: Text(
//                                                     Languages.of(context)
//                                                         .txtWeekGoalDesc,
//                                                     textAlign:
//                                                     TextAlign.center,
//                                                     overflow: TextOverflow
//                                                         .ellipsis,
//                                                     style: const TextStyle(
//                                                         color: Colur.grey,
//                                                         fontSize: 14,
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .w400)),
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   // Navigator.push(
//                                                   //     context,
//                                                   //     MaterialPageRoute(
//                                                   //         builder: (context) =>
//                                                   //             SetWeeklyGoalScreen())).then(
//                                                   //         (value) =>
//                                                   //         _getPreference());
//                                                 },
//                                                 child: Container(
//                                                   padding:
//                                                   const EdgeInsets.all(
//                                                       15),
//                                                   decoration:
//                                                   const BoxDecoration(
//                                                     gradient:
//                                                     LinearGradient(
//                                                         colors: [
//                                                           Colur
//                                                               .blueGradient1,
//                                                           Colur
//                                                               .blueGradient2,
//                                                         ],
//                                                         begin: Alignment
//                                                             .centerLeft,
//                                                         end: Alignment
//                                                             .centerRight,
//                                                         stops: [
//                                                           0.0,
//                                                           1.0
//                                                         ],
//                                                         tileMode:
//                                                         TileMode
//                                                             .clamp),
//                                                     borderRadius:
//                                                     BorderRadius.all(
//                                                         Radius.circular(
//                                                             30)),
//                                                   ),
//                                                   margin: const EdgeInsets
//                                                       .symmetric(
//                                                       vertical: 15,
//                                                       horizontal: 20),
//                                                   child: Center(
//                                                     child: Text(
//                                                         Languages.of(
//                                                             context)
//                                                             .txtSetAGoal
//                                                             .toUpperCase(),
//                                                         textAlign: TextAlign
//                                                             .center,
//                                                         overflow:
//                                                         TextOverflow
//                                                             .ellipsis,
//                                                         style: const TextStyle(
//                                                             color:
//                                                             Colors.white,
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w500)),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                               : Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                             children: [
//                                               InkWell(
//                                                 onTap: () {
//                                                   // Navigator.push(
//                                                   //     context,
//                                                   //     MaterialPageRoute(
//                                                   //         builder: (context) =>
//                                                   //             SetWeeklyGoalScreen())).then(
//                                                   //         (value) =>
//                                                   //         _getPreference());
//                                                 },
//                                                 child: Row(
//                                                   children: [
//                                                     Container(
//                                                       margin:
//                                                       const EdgeInsets
//                                                           .only(
//                                                           left: 10,
//                                                           bottom: 10),
//                                                       child: Text(
//                                                           Languages
//                                                               .of(
//                                                               context)
//                                                               .txtWeekGoal
//                                                               .toUpperCase(),
//                                                           overflow:
//                                                           TextOverflow
//                                                               .ellipsis,
//                                                           style: const TextStyle(
//                                                               color: Colur
//                                                                   .black,
//                                                               fontSize: 16,
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w500)),
//                                                     ),
//                                                     Container(
//                                                         margin:
//                                                         const EdgeInsets
//                                                             .only(
//                                                             left: 10,
//                                                             bottom: 10),
//                                                         child: Icon(
//                                                             Icons
//                                                                 .edit_rounded,
//                                                             size: 15)),
//                                                     Expanded(
//                                                       child: Container(
//                                                         margin:
//                                                         const EdgeInsets
//                                                             .only(
//                                                             right: 10,
//                                                             bottom: 10),
//                                                         alignment: Alignment
//                                                             .centerRight,
//                                                         child: Text(
//                                                           "${model.totalDayOfWeekGoal.toString()}/" +
//                                                               model.selectedTrainingDay,
//                                                           style: TextStyle(
//                                                               fontSize: 14),
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 margin:
//                                                 const EdgeInsets.only(
//                                                     top: 15.0),
//                                                 alignment: Alignment.center,
//                                                 height: 40,
//                                                 child: ListView.builder(
//                                                   scrollDirection:
//                                                   Axis.horizontal,
//                                                   shrinkWrap: true,
//                                                   physics: NeverScrollableScrollPhysics(),
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                       int index) {
//                                                     return _itemOfWeekGoal(index, model);
//                                                   },
//                                                   itemCount:
//                                                   model.isAvailableHistory
//                                                       .length,
//                                                 ),
//                                               ),
//                                             ],
//                                           )),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ];
//                   },
//                   controller: _scrollController,
//                   body: Container(
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 _widgetListOfPlan(model),
//                                 _widgetDiscover(),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // (_isBottomBannerAdLoaded && !Utils.isPurchased())
//                         //     ? Container(
//                         //   height: _bottomBannerAd.size.height.toDouble(),
//                         //   width: _bottomBannerAd.size.width.toDouble(),
//                         //   child: AdWidget(ad: _bottomBannerAd),
//                         // )
//                         //     : Container()
//                       ],
//                     ),
//                   ),
//                 )
//             ),
//
//           ],
//         );
//       },
//     );
//   }
//
//   _itemOfWeekGoal(int index, CategoriesViewModel model) {
//     return Container(
//       width: MediaQuery.of(context).size.width / 8,
//       child: Column(
//         children: [
//           (model.isAvailableHistory.isNotEmpty && !model.isAvailableHistory[index])
//               ? Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(width: 0.5, color: Colors.black)),
//             child: Container(
//                 alignment: Alignment.center,
//                 child: Text(
//                   Utils.getDaysDateOfWeek(Preference.shared.getInt(
//                       Preference.SELECTED_FIRST_DAY_OF_WEEK) ??
//                       0)[index]
//                       .toString(),
//                   textAlign: TextAlign.center,
//                 )),
//           )
//               : Container(
//               alignment: Alignment.center,
//               child: Image.asset(
//                 "assets/icons/ic_challenge_complete_day.webp",
//                 height: 40,
//                 width: 40,
//               ))
//         ],
//       ),
//     );
//   }
//
//   _widgetListOfPlan(CategoriesViewModel model) {
//     return ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: model.allPlanDataList.length,
//       padding: const EdgeInsets.all(0),
//       itemBuilder: (BuildContext context, int index) {
//         return itemPlan(index, model);
//       },
//     );
//   }
//
//   DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
//
//   itemPlan(int index, CategoriesViewModel model) {
//     var t = model.allPlanDataList[index].catTableName != null
//         ? Preference.shared.getLastTime(model.allPlanDataList[index].catTableName) ??
//         null
//         : null;
//     var lastTime = " ";
//     if (t != null) {
//       if (getDate(DateTime.parse(t)) == getDate(DateTime.now())) {
//         lastTime = "Today";
//       } else if (getDate(DateTime.parse(t)) ==
//           getDate(DateTime.now().subtract(Duration(days: 1)))) {
//         lastTime = "Yesterday";
//       } else {
//         lastTime = DateFormat.MMMd().format(DateTime.parse(t));
//       }
//     }
//
//     var gender = Preference.shared.getString(Constant.SELECTED_GENDER) ?? Constant.GENDER_MEN;
//
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Visibility(
//             visible: (model.allPlanDataList[index].catSubCategory == Constant.title)
//                 ? true
//                 : false,
//             child: Container(
//               margin: const EdgeInsets.only(top: 10, left: 5),
//               child: Text(
//                 model.allPlanDataList[index].catName.toString().toUpperCase(),
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 17,
//                   color: Colur.black,
//                 ),
//               ),
//             ),
//           ),
//           Visibility(
//               visible: (model.allPlanDataList[index].catSubCategory != Constant.title)
//                   ? true
//                   : false,
//               child: Container(
//                 height: 130,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage((model.allPlanDataList[index].catImage !=
//                               Constant.title)
//                               ? model.allPlanDataList[index].catImage +
//                               "_$gender.webp"
//                               : 'assets/exerciseImage/beginner/abs_beginner_men.webp'),
//                           fit: BoxFit.cover),
//                       shape: BoxShape.rectangle,
//                     ),
//                     child: Container(
//                       color: Colur.transparent_black_50,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Visibility(
//                             visible: _isDayStatusPlan(index, model) ? true : false,
//                             child: Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   print(model.allPlanDataList[index].catName);
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               ExerciseDaysStatusScreen(
//                                                 planName: model.allPlanDataList[index]
//                                                     .catName,
//                                               )));
//                                 },
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 15.0),
//                                             child: Text(
//                                               model.allPlanDataList[index]
//                                                   .catName
//                                                   .toUpperCase(),
//                                               maxLines: 1,
//                                               softWrap: true,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 18,
//                                                   color: Colur.white),
//                                             ),
//                                           ),
//                                           Container(
//                                             margin: const EdgeInsets.symmetric(
//                                               horizontal: 15.0,
//                                             ),
//                                             child: Text(
//                                                 Languages.of(context)
//                                                     .txt7X4Challenge
//                                                     .toUpperCase(),
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Colur.white,
//                                                     fontSize: 14.0)),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Visibility(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.end,
//                                         children: [
//                                           Container(
//                                             child: Row(
//                                               children: [
//                                                 FutureBuilder(
//                                                   future:
//                                                   _setLeftDayProgressDataByPlan(
//                                                       model.allPlanDataList[index]
//                                                           .catTableName
//                                                           .toString()),
//                                                   builder:
//                                                       (BuildContext context,
//                                                       AsyncSnapshot<dynamic>
//                                                       snapshot) {
//                                                     if (snapshot.hasData) {
//                                                       return Visibility(
//                                                         visible: snapshot.data
//                                                             .toString() !=
//                                                             "28" +
//                                                                 " " +
//                                                                 Languages.of(
//                                                                     context)
//                                                                     .txtDayLeft,
//                                                         child: Container(
//                                                           margin:
//                                                           const EdgeInsets
//                                                               .symmetric(
//                                                               horizontal:
//                                                               15.0),
//                                                           child: Text(
//                                                               snapshot.data
//                                                                   .toString(),
//                                                               style: TextStyle(
//                                                                   color: Colur
//                                                                       .white,
//                                                                   fontSize:
//                                                                   14.0)),
//                                                         ),
//                                                       );
//                                                     } else {
//                                                       return Container();
//                                                     }
//                                                   },
//                                                 ),
//                                                 Expanded(
//                                                   child: FutureBuilder(
//                                                     future:
//                                                     _setDayProgressPercentagePlan(
//                                                         model.allPlanDataList[
//                                                         index]
//                                                             .catTableName
//                                                             .toString()),
//                                                     builder: (BuildContext
//                                                     context,
//                                                         AsyncSnapshot<dynamic>
//                                                         snapshot) {
//                                                       if (snapshot.hasData) {
//                                                         return Visibility(
//                                                           visible: snapshot.data
//                                                               .toString() !=
//                                                               "0%",
//                                                           child: Container(
//                                                             alignment: Alignment
//                                                                 .centerRight,
//                                                             margin:
//                                                             const EdgeInsets
//                                                                 .symmetric(
//                                                                 horizontal:
//                                                                 15.0),
//                                                             child: Text(
//                                                                 snapshot.data
//                                                                     .toString(),
//                                                                 style: TextStyle(
//                                                                     color: Colur
//                                                                         .white,
//                                                                     fontSize:
//                                                                     14.0)),
//                                                           ),
//                                                         );
//                                                       } else {
//                                                         return Container();
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           FutureBuilder(
//                                             future: _setDayProgressDataByPlan(
//                                                 model.allPlanDataList[index]
//                                                     .catTableName.toString(), model),
//                                             builder: (BuildContext context,
//                                                 AsyncSnapshot<dynamic>
//                                                 snapshot) {
//                                               if (snapshot.hasData) {
//                                                 return Visibility(
//                                                   visible: snapshot.data != 0,
//                                                   child: Container(
//                                                     margin:
//                                                     const EdgeInsets.only(
//                                                         right: 10,
//                                                         left: 10,
//                                                         top: 10,
//                                                         bottom: 20),
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                       BorderRadius.circular(
//                                                           10.0),
//                                                       child:
//                                                       LinearProgressIndicator(
//                                                         value: (snapshot.data /
//                                                             100)
//                                                             .toDouble(),
//                                                         valueColor:
//                                                         AlwaysStoppedAnimation<
//                                                             Color>(
//                                                             Colur.theme),
//                                                         backgroundColor: Colur
//                                                             .transparent_50,
//                                                         minHeight: 5,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 );
//                                               } else {
//                                                 return Container();
//                                               }
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Visibility(
//                             visible: (model.allPlanDataList[index].catSubCategory ==
//                                 Constant.titleQuarantineAtHome &&
//                                 model.allPlanDataList[index].catSubCategory !=
//                                     Constant.txt_7_4_challenge)
//                                 ? true
//                                 : false,
//                             child: Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) =>
//                                   //             QuarantineAtHomeScreen()));
//                                 },
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             width: double.infinity,
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 15.0),
//                                             child: Text(
//                                               model.allPlanDataList[index]
//                                                   .catName
//                                                   .toUpperCase(),
//                                               maxLines: 2,
//                                               softWrap: true,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 18,
//                                                   color: Colur.white),
//                                             ),
//                                           ),
//                                           Container(
//                                             width: double.infinity,
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 15.0, vertical: 5),
//                                             child: Text(
//                                                 "${model.totalQuarantineWorkout} " +
//                                                     Languages.of(context)
//                                                         .txtWorkouts
//                                                         .toLowerCase(),
//                                                 style: TextStyle(
//                                                     color: Colur.white,
//                                                     fontSize: 16.0,
//                                                     fontWeight:
//                                                     FontWeight.w700)),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                         margin: const EdgeInsets.symmetric(
//                                             horizontal: 15),
//                                         child: Image.asset(
//                                           "assets/icons/ic_arrow.webp",
//                                           height: 25,
//                                           width: 25,
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Visibility(
//                             visible: (model.allPlanDataList[index].catSubCategory !=
//                                 Constant.titleQuarantineAtHome &&
//                                 model.allPlanDataList[index].catSubCategory !=
//                                     Constant.txt_7_4_challenge)
//                                 ? true
//                                 : false,
//                             child: Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) =>
//                                   //             ExerciseListScreen(
//                                   //               homePlanTable:
//                                   //               allPlanDataList[index],
//                                   //               fromPage: Constant.PAGE_HOME,
//                                   //               planName: allPlanDataList[index]
//                                   //                   .catName,
//                                   //             )));
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           width: double.infinity,
//                                           margin: const EdgeInsets.symmetric(
//                                               horizontal: 15.0, vertical: 15),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 model.allPlanDataList[index]
//                                                     .catName
//                                                     .toUpperCase(),
//                                                 maxLines: 1,
//                                                 softWrap: true,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 18,
//                                                     color: Colur.white),
//                                               ),
//                                               Visibility(
//                                                 visible: t != null,
//                                                 child: Text(
//                                                     Languages.of(context)
//                                                         .txtLastTime +
//                                                         lastTime,
//                                                     maxLines: 1,
//                                                     softWrap: true,
//                                                     overflow:
//                                                     TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                       FontWeight.w300,
//                                                       fontSize: 16,
//                                                       color: Colur.borderGray,
//                                                     )),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                           alignment: Alignment.bottomLeft,
//                                           width: double.infinity,
//                                           margin: const EdgeInsets.symmetric(
//                                               horizontal: 15.0, vertical: 10),
//                                           child: Image.asset(
//                                             _getLevelImage(
//                                                 model.allPlanDataList[index]
//                                                     .catSubCategory
//                                                     .toString()),
//                                             scale: 3.5,
//                                           )),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
//
//   String _getLevelImage(String planLevel) {
//     String levelName = "";
//     if (planLevel != Constant.titleQuarantineAtHome &&
//         planLevel != Constant.txt_7_4_challenge &&
//         planLevel != Constant.title) {
//       if (planLevel == Constant.strBeginner) {
//         levelName = "assets/icons/ic_1_star.webp";
//       } else if (planLevel == Constant.strIntermediate) {
//         levelName = "assets/icons/ic_2_star.webp";
//       } else if (planLevel == Constant.strAdvance) {
//         levelName = "assets/icons/ic_3_star.webp";
//       } else {
//         levelName = "assets/icons/ic_3_star.webp";
//       }
//     }
//     return levelName;
//   }
//
//   bool _isDayStatusPlan(int index, CategoriesViewModel model) {
//     return (model.allPlanDataList[index].catSubCategory ==
//         Constant.txt_7_4_challenge &&
//         model.allPlanDataList[index].catSubCategory != Constant.catQuarantineAtHome);
//   }
//
//   _widgetDiscover() {
//     return InkWell(
//       onTap: () {
//         // Preference.shared.setInt(Preference.DRAWER_INDEX, 1);
//         // Navigator.push(
//         //     context, MaterialPageRoute(builder: (context) => DiscoverScreen()));
//       },
//       child: Container(
//         margin: const EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 20),
//         height: 80,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/images/bg_libray.webp'),
//               fit: BoxFit.cover),
//           borderRadius: BorderRadius.circular(8),
//           shape: BoxShape.rectangle,
//           boxShadow: [
//             BoxShadow(
//               color: Colur.transparent_black_50,
//               offset: Offset(0.0, 1.0),
//               blurRadius: 5.0,
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(
//                         top: 15, right: 15, left: 15, bottom: 5),
//                     child: Text(
//                       Languages.of(context).txtDiscover.toUpperCase(),
//                       maxLines: 1,
//                       softWrap: true,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 18,
//                           color: Colur.white),
//                     ),
//                   ),
//                   Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Text(
//                         Languages.of(context).txtMoreWorkout,
//                         style: TextStyle(color: Colur.transparent_90),
//                       ))
//                 ],
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                   color: Colur.white, borderRadius: BorderRadius.circular(20)),
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 child: Text(Languages.of(context).txtGo + "!"),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void onTopBarClick(String name, {bool value = true}) {}
//
//   Future<int> _setDayProgressDataByPlan(String strTableName, CategoriesViewModel model) async {
//     if (strTableName == Constant.tbl_full_body_workouts_list ||
//         strTableName == Constant.tbl_lower_body_list) {
//       List<FullBodyWorkoutTable> compDay =
//       await DataBaseHelper().getCompleteDayCountByTableName(strTableName);
//       String proPercentage =
//       (compDay.length.toDouble() * 100 / 28).toDouble().toStringAsFixed(0);
//       model.progress = proPercentage + "%";
//       return double.parse(proPercentage).toInt();
//     } else {
//       return 0;
//     }
//   }
//
//   Future<String> _setLeftDayProgressDataByPlan(String strTableName) async {
//     if (strTableName == Constant.tbl_full_body_workouts_list ||
//         strTableName == Constant.tbl_lower_body_list) {
//       List<FullBodyWorkoutTable> compDay =
//       await DataBaseHelper().getCompleteDayCountByTableName(strTableName);
//       String daysLeft = (28 - compDay.length).toString();
//       return daysLeft + " " + Languages.of(context).txtDayLeft;
//     } else {
//       return "";
//     }
//   }
//
//   Future<String> _setDayProgressPercentagePlan(String strTableName) async {
//     if (strTableName == Constant.tbl_full_body_workouts_list ||
//         strTableName == Constant.tbl_lower_body_list) {
//       List<FullBodyWorkoutTable> compDay =
//       await DataBaseHelper().getCompleteDayCountByTableName(strTableName);
//       String proPercentage =
//       (compDay.length.toDouble() * 100 / 28).toDouble().toStringAsFixed(0);
//       return proPercentage + "%";
//     } else {
//       return "";
//     }
//   }
//
// }
