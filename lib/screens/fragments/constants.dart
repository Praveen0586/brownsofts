import 'package:get/get.dart';

RxString username = "".obs;
RxString useremail = "".obs;

//user enterin Description to Purchase a service
RxString userdescription = "".obs;

//after selecting a service to purchase
RxString selectedserviceName = "".obs;
RxInt selectedservicePrice = 0.obs;
// RxString selectedserviceId = "".obs;
RxString selectedServiceId = "".obs;
RxString selectedPricePackage = "".obs;

RxList purchasedServices = [].obs;
