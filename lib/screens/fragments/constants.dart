import 'package:get/get.dart';

RxString username = "".obs;
RxString useremail = "".obs;
RxString userID = "".obs;

//user enterin Description to Purchase a service
RxString userdescription = "".obs;

//after selecting a service to purchase
RxString selectedserviceName = "".obs;
RxInt selectedservicePrice = 0.obs;
// RxString selectedserviceId = "".obs;
RxString selectedServiceId = "".obs;
RxString selectedPricePackage = "".obs;
RxList purchasedServices = [].obs;

class SampleNetworkImages {
  static String userProfilePic =
      "https://tse3.mm.bing.net/th/id/OIP.yq_YbbR2Nqbk-Q5r2VoCDwHaHa?rs=1&pid=ImgDetMain&o=7&rm=3";
}
