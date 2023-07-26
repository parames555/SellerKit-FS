// ignore_for_file: prefer_const_constructors

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sellerkit/Pages/DayStartEnd/Screens/DayEnd.dart';
import 'package:sellerkit/Pages/LeaveRequest/Screen/LeaveReqPage.dart';
// import 'package:sellerkit/Pages/Leads/NewLead.dart';
// import 'package:sellerkit/Pages/Leads/Widgets/OpenLead.dart';
import 'package:sellerkit/Pages/Login/Screen/LoginScreen.dart';
import 'package:sellerkit/Pages/Mycustomer/screens/Accounts.dart';
import 'package:sellerkit/Pages/OnBoarding/OnBoardingScreen.dart';
import 'package:sellerkit/Pages/PriceAvailability/Screen/PriceDetailsPage.dart';
import 'package:sellerkit/Pages/SiteIn/Widgets/NewSiteIn.dart';
import 'package:sellerkit/Pages/Splash/Screen/SplashPage.dart';
import 'package:sellerkit/Pages/Notification/Screens/Notifications.dart';
// import '../Pages/Collection/NewCollectionEntry.dart';
// import '../Pages/Collection/Screens/CollectionList.dart';
// import '../Pages/Collection/widgets/CollectionSuccessPage.dart';
import '../Pages/Collection/NewCollectionEntry.dart';
import '../Pages/Collection/Screens/CollectionList.dart';
import '../Pages/Collection/widgets/CollectionSuccessPage.dart';
import '../Pages/Dashboard/Screens/Dashboard.dart';
import '../Pages/Dashboard/widgets/PhotoViwer.dart';
// import '../Pages/DayStartEnd/Screens/DayStartEnd.dart';
// import '../Pages/DayStartEnd/Widgets/CameraPage.dart';
import '../Pages/DayStartEnd/Screens/DayStart.dart';
import '../Pages/DayStartEnd/Widgets/CameraPage.dart';
import '../Pages/DownloadDatasPage.dart/DownloadDataPage.dart';
import '../Pages/Enquiries/EnquiryManger/EnquiryManagerPage.dart';
import '../Pages/Enquiries/EnquiriesUser/EnquiryPageUser.dart';
import '../Pages/Enquiries/NewEnquiry.dart';
import '../Pages/FeedCreation/Screen/FeedCrtscreen.dart';
import '../Pages/Followup/Screens/FollowUpNew.dart';
import '../Pages/Followup/Screens/FollowUpScreen.dart';
import '../Pages/Followup/Screens/FollowUpTabScreen.dart';
import '../Pages/ForgotPassword/Screens/ForgotPassword.dart';
import '../Pages/ForgotPassword/widgets/ConfirmPassword.dart';
import '../Pages/GoalTracker/Screen/GoalTracker.dart';
// import '../Pages/Leads/Screens/LeadSuccessPage.dart';
// import '../Pages/Leads/Screens/TabLeads.dart';
import '../Pages/MyEarnings/Screens/MyEarnings.dart';
import '../Pages/MyPerformance/Screens/MyPerformance.dart';
// import '../Pages/Mycustomer/NewCustomer.dart';
// import '../Pages/Mycustomer/screens/AccoountsDetails.dart';
// import '../Pages/Mycustomer/screens/Accounts.dart';
import '../Pages/Mycustomer/NewCustomer.dart';
import '../Pages/Mycustomer/screens/AccoountsDetails.dart';
import '../Pages/OfferZone/Screens/OfferZone.dart';
import '../Pages/OpenLead/Screen/FilterOpenLeadPage.dart';
import '../Pages/OpenLead/Screen/OpenLeadPage.dart';
import '../Pages/OrderBooking/NewLead.dart';
import '../Pages/OrderBooking/Screens/LeadSuccessPage.dart';
import '../Pages/OrderBooking/Screens/TabLeads.dart';
import '../Pages/PriceAvailability/Screen/ViewAllPriceListPage.dart';
import '../Pages/PriceAvailability/Screen/PriceListFstPage.dart';
import '../Pages/Profile/Screen/Newprofile.dart';
import '../Pages/ScoreCard/Screens/ScoreCard1Screens.dart';
import '../Pages/ScaningPage/Screens/ScreenShot.dart';
import '../Pages/ScreenShotPage/Screen/ScreenShotPage.dart';
import '../Pages/Settlement/Screens/SettlementTabPage.dart';
import '../Pages/SiteIn/Screens/SiteInPage.dart';
import '../Pages/SiteOut/Screens/SiteOut.dart';
import '../Pages/Stock Availability/screens/StockDetailsPage.dart';
import '../Pages/Stock Availability/screens/StockListFPage.dart';
import '../Pages/Stock Availability/screens/ViewAllStockListPage.dart';
// import '../Pages/VisitPlans/Screens/NewVisitPlan.dart';
// import '../Pages/VisitPlans/visitplanScreen.dart';
import '../Pages/VisitPlans/Screens/NewVisitPlan.dart';
import '../Pages/VisitPlans/visitplanScreen.dart';
import '../Pages/Walkins/Screens/Walkins.dart';
import 'ConstantRoutes.dart';

class Routes {
  static List<GetPage> allRoutes = [
    GetPage<dynamic>(
        name: ConstantRoutes.dashboard,
        page: () => Dashboard(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.dashboard,
        page: () => Dashboard(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.login,
        page: () => LoginPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.splash,
        page: () => SplashPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.register,
        page: () => RegisterPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.download,
        page: () => DownloadPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.onBoard,
        page: () => OnBoardingScreen(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    //Resource

    GetPage<dynamic>(
        name: ConstantRoutes.stock,
        page: () => StockAvail(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.stockListOfDetails,
        page: () => StockListOfDetails(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.listStockAvailability,
        page: () => ListStockAvailability(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.priceList,
        page: () => PriceAvailability(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.priceListViewAll,
        page: () => PriceListOfDetails(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.priceListViewData,
        page: () => ListPriceAvailability(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    // performance

    GetPage<dynamic>(
        name: ConstantRoutes.performance,
        page: () => MyPerformance(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.scoreCardScreenOne,
        page: () => ScoreCardScreenOne(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.earnings,
        page: () => MyEarnings(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    //pre sales
    GetPage<dynamic>(
        name: ConstantRoutes.enquiriesManager,
        page: () => EnquiryManagerPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.enquiriesUser,
        page: () => EnquiryUserPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.walkins,
        page: () => WalkinsPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.leads,
        page: () => LeadBookNew(), //LeadBook(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.leadstab,
        page: () => LeadsTabPage(), //LeadBook(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.newEnq,
        page: () => NewEnquiry(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.successLead,
        page: () => LeadSuccessPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.followup,
        page: () => FollowUpPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.followupNew,
        page: () => FollowUpNew(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.followupTab,
        page: () => FollowUpTab(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.openLeadPage,
        page: () => OpenLeadPageFoll(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    // GetPage<dynamic>(
    // name: ConstantRoutes.filtrOPLP,
    // page: () => FilterOpenLeadPage(),
    // transition: Transition.fade,
    // transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.newprofile,
        page: () => NewProfile(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.targets,
        page: () => GoalTracker(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.testing,
        page: () => Testing(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.accounts,
        page: () => Accounts(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.accountsDetails,
        page: () => AccountsDetails(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.offerZone,
        page: () => OfferZone(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.confirmPassWord,
        page: () => ConfirmPasswordPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.photoViewer,
        page: () => PhotoViewer(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.feedsCreation,
        page: () => FeedCrt(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.scanQrcode,
        page: () => ScanningPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.screenshot,
        page: () => ScreenShotPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.daystartend,
        page: () => DayStartEndPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.cameraPage,
        page: () => cameraPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.visitplan,
        page: () => visitplanPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.newvisitplan,
        page: () => NewVisitPlan(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.newcustomerReg,
        page: () => NewCustomerReg(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.collectionlist,
        page: () => Collections(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.newcollection,
        page: () => NewCollectionEntry(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.collectioSuccess,
        page: () => CollectionSuccessPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.settlement,
        page: () => SettlementTabPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.sitein,
        page: () => SiteInPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.newsitein,
        page: () => NewSiteIn(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.siteOut,
        page: () => SiteOut(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.dayEndPage,
        page: () => DayEndPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),

          GetPage<dynamic>(
        name: ConstantRoutes.leaveReq,
        page: () => LeaveReqPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
  ];
}
