import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/services/alert.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/view_models/checkout_base.vm.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dartx/dartx.dart';

class MultipleCheckoutViewModel extends CheckoutBaseViewModel {
  List<Vendor> vendors = [];
  List<Map<String, dynamic>> orderData = [];
  double totalTax = 0;
  double totalDeliveryFee = 0;
  List<double> taxes = [];
  List<double> subtotals = [];

  MultipleCheckoutViewModel(BuildContext context, CheckOut checkout) {
    this.viewContext = context;
    this.checkout = checkout;
  }

  //
  void initialise() async {
    super.initialise();
    fetchVendorsDetails();

    //
    updateTotalOrderSummary();
  }

  //
  fetchVendorsDetails() async {
    //
    vendors = CartServices.productsInCart
        .map((e) => e.product.vendor)
        .toList()
        .toSet()
        .toList();

    vendors = vendors.distinctBy((model) => model.id).toList();
    //
    setBusy(true);
    try {
      for (var i = 0; i < vendors.length; i++) {
        vendors[i] = await vendorRequest.vendorDetails(
          vendors[i].id,
          params: {
            "type": "brief",
          },
        );
      }
    } catch (error) {
      print("Error Getting Vendor Details ==> $error");
    }
    setBusy(false);
  }

  //update total/order amount summary
  updateTotalOrderSummary() async {
    //clear previous data
    checkout.tax = 0;
    checkout.deliveryFee = 0;
    orderData = [];
    totalTax = 0;
    totalDeliveryFee = 0;
    taxes = [];
    subtotals = [];

    //delivery fee
    if (!isPickup && deliveryAddress != null) {
      //selected delivery address is within range
      if (!delievryAddressOutOfRange) {
        //vendor charges per km
        setBusy(true);

        //
        for (var i = 0; i < vendors.length; i++) {
          //
          final mVendor = vendors[i];
          double mDeliveryFee = 0.0;

          //
          try {
            double orderDeliveryFee = await checkoutRequest.orderSummary(
              deliveryAddressId: deliveryAddress.id,
              vendorId: mVendor.id,
            );

            //adding base fee
            mDeliveryFee += orderDeliveryFee;
          } catch (error) {
            if (mVendor.chargePerKm != null && mVendor.chargePerKm == 1) {
              mDeliveryFee += mVendor.deliveryFee * deliveryAddress.distance;
            } else {
              mDeliveryFee += mVendor.deliveryFee;
            }

            //adding base fee
            mDeliveryFee += mVendor.baseDeliveryFee;
          }
          updateOrderData(mVendor, deliveryFee: mDeliveryFee);
          //
        }

        //
        setBusy(false);
      } else {
        checkout.deliveryFee = 0.00;
      }
    } else {
      checkout.deliveryFee = 0.00;

      for (var i = 0; i < vendors.length; i++) {
        final mVendor = vendors[i];
        updateOrderData(mVendor);
        //
      }
    }

    //total tax number
    totalTax = (totalTax / (100 * vendors.length)) * 100;
    //total
    checkout.total = (checkout.subTotal - checkout.discount) +
        totalDeliveryFee +
        checkout.tax;

    //
    updateCheckoutTotalAmount();
    updatePaymentOptionSelection();
    notifyListeners();
  }

  updateOrderData(mVendor, {double deliveryFee = 0.00}) {
    //tax
    double calTax = (double.parse(mVendor.tax ?? "0") / 100);
    double vendorSubtotal = CartServices.vendorSubTotal(mVendor.id);
    calTax = calTax * vendorSubtotal;
    checkout.tax += calTax;
    totalTax += double.parse(mVendor.tax ?? "0");
    totalDeliveryFee += deliveryFee;
    taxes.add(calTax);
    subtotals.add(vendorSubtotal);

    //
    double vendorDiscount = CartServices.vendorOrderDiscount(
      mVendor.id,
      checkout.coupon,
    );
    //total amount for that single order
    double vendorTotal =
        (vendorSubtotal - vendorDiscount) + deliveryFee + calTax;
    //
    final orderObject = {
      "vendor_id": mVendor.id,
      "delivery_fee": deliveryFee,
      "tax": calTax,
      "sub_total": vendorSubtotal,
      "discount": vendorDiscount,
      "tip": 0,
      "total": vendorTotal,
    };

    //prepare order data
    final orderDataIndex = orderData.indexWhere(
      (e) => e.containsKey("vendor_id") && e["vendor_id"] == mVendor.id,
    );
    if (orderDataIndex >= 0) {
      orderData[orderDataIndex] = orderObject;
    } else {
      orderData.add(orderObject);
    }
  }

//
  processOrderPlacement() async {
    //process the order placement
    setBusy(true);
    //prepare order data
    orderData = orderData.map((e) {
      e.addAll({
        "products": CartServices.multipleVendorOrderPayload(e["vendor_id"]),
      });
      return e;
    }).toList();

    //set the total with discount as the new total
    checkout.total = checkout.totalWithTip;
    //
    final apiResponse = await checkoutRequest.newMultipleVendorOrder(
      checkout,
      tip: driverTipTEC.text,
      note: noteTEC.text,
      payload: {
        "data": orderData,
      },
    );
    //not error
    if (apiResponse.allGood) {
      //any payment
      await AlertService.success(
        title: "Checkout".tr(),
        text: apiResponse.message,
      );
      showOrdersTab(context: viewContext);
      if (viewContext.navigator.canPop()) {
        viewContext.navigator.popUntil(
          ModalRoute.withName(AppRoutes.homeRoute),
        );
      }
    } else {
      await AlertService.error(
        title: "Checkout".tr(),
        text: apiResponse.message,
      );
    }
    setBusy(false);
  }
}
