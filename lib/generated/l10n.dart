// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Error happened`
  String get errorHappened {
    return Intl.message(
      'Error happened',
      name: 'errorHappened',
      desc: '',
      args: [],
    );
  }

  /// `Every thing is ok`
  String get statusCodeOk {
    return Intl.message(
      'Every thing is ok',
      name: 'statusCodeOk',
      desc: '',
      args: [],
    );
  }

  /// `You logging in successfully`
  String get loginSuccess {
    return Intl.message(
      'You logging in successfully',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message(
      'Try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection`
  String get pleaseCheckYourInternetConnection {
    return Intl.message(
      'Please check your internet connection',
      name: 'pleaseCheckYourInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `This error happened`
  String get thisErrorHappened {
    return Intl.message(
      'This error happened',
      name: 'thisErrorHappened',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to`
  String get welcomeTo {
    return Intl.message(
      'Welcome to',
      name: 'welcomeTo',
      desc: '',
      args: [],
    );
  }

  /// `Your number 1 business partner`
  String get youBusinessPartner {
    return Intl.message(
      'Your number 1 business partner',
      name: 'youBusinessPartner',
      desc: '',
      args: [],
    );
  }

  /// `This field cannot be empty`
  String get pleaseCompleteField {
    return Intl.message(
      'This field cannot be empty',
      name: 'pleaseCompleteField',
      desc: '',
      args: [],
    );
  }

  /// `Enter terminal ID`
  String get enterTerminalId {
    return Intl.message(
      'Enter terminal ID',
      name: 'enterTerminalId',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Please select a branch.`
  String get plzSelectBranch {
    return Intl.message(
      'Please select a branch.',
      name: 'plzSelectBranch',
      desc: '',
      args: [],
    );
  }

  /// `workers`
  String get workers {
    return Intl.message(
      'workers',
      name: 'workers',
      desc: '',
      args: [],
    );
  }

  /// `Worker`
  String get worker {
    return Intl.message(
      'Worker',
      name: 'worker',
      desc: '',
      args: [],
    );
  }

  /// `Sales`
  String get sellers {
    return Intl.message(
      'Sales',
      name: 'sellers',
      desc: '',
      args: [],
    );
  }

  /// `Add Worker`
  String get addWorker {
    return Intl.message(
      'Add Worker',
      name: 'addWorker',
      desc: '',
      args: [],
    );
  }

  /// `Edit Worker`
  String get editWorker {
    return Intl.message(
      'Edit Worker',
      name: 'editWorker',
      desc: '',
      args: [],
    );
  }

  /// `Employee name`
  String get employeeName {
    return Intl.message(
      'Employee name',
      name: 'employeeName',
      desc: '',
      args: [],
    );
  }

  /// `Sales`
  String get sales {
    return Intl.message(
      'Sales',
      name: 'sales',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `InActive`
  String get inActive {
    return Intl.message(
      'InActive',
      name: 'inActive',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter all data`
  String get plzEnterAllData {
    return Intl.message(
      'Please enter all data',
      name: 'plzEnterAllData',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Download Report of Transactions`
  String get downloadReportOfTrans {
    return Intl.message(
      'Download Report of Transactions',
      name: 'downloadReportOfTrans',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Refunded Successfully.`
  String get transactionClaimedSuccessfully {
    return Intl.message(
      'Transaction Refunded Successfully.',
      name: 'transactionClaimedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Details`
  String get transactionDetails {
    return Intl.message(
      'Transaction Details',
      name: 'transactionDetails',
      desc: '',
      args: [],
    );
  }

  /// `Transaction No`
  String get transactionNo {
    return Intl.message(
      'Transaction No',
      name: 'transactionNo',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Offline Id`
  String get transactionOfflineId {
    return Intl.message(
      'Transaction Offline Id',
      name: 'transactionOfflineId',
      desc: '',
      args: [],
    );
  }

  /// `Voucher`
  String get voucher {
    return Intl.message(
      'Voucher',
      name: 'voucher',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Refund Partially`
  String get claimPartially {
    return Intl.message(
      'Refund Partially',
      name: 'claimPartially',
      desc: '',
      args: [],
    );
  }

  /// `Cashier`
  String get cashier {
    return Intl.message(
      'Cashier',
      name: 'cashier',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get action {
    return Intl.message(
      'Action',
      name: 'action',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Refund`
  String get claim {
    return Intl.message(
      'Refund',
      name: 'claim',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Add Table`
  String get addTable {
    return Intl.message(
      'Add Table',
      name: 'addTable',
      desc: '',
      args: [],
    );
  }

  /// `Edit Table`
  String get editTable {
    return Intl.message(
      'Edit Table',
      name: 'editTable',
      desc: '',
      args: [],
    );
  }

  /// `Delete Table`
  String get deleteTable {
    return Intl.message(
      'Delete Table',
      name: 'deleteTable',
      desc: '',
      args: [],
    );
  }

  /// `TableName`
  String get tableName {
    return Intl.message(
      'TableName',
      name: 'tableName',
      desc: '',
      args: [],
    );
  }

  /// `Table Number`
  String get tableNumber {
    return Intl.message(
      'Table Number',
      name: 'tableNumber',
      desc: '',
      args: [],
    );
  }

  /// `Table Capacity`
  String get tableCapacity {
    return Intl.message(
      'Table Capacity',
      name: 'tableCapacity',
      desc: '',
      args: [],
    );
  }

  /// `Policy & Privacy`
  String get policyPrivacy {
    return Intl.message(
      'Policy & Privacy',
      name: 'policyPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `You can request to delete your account`
  String get requestDeleteAccount {
    return Intl.message(
      'You can request to delete your account',
      name: 'requestDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Deleting your account will:`
  String get deleteAccountWill {
    return Intl.message(
      'Deleting your account will:',
      name: 'deleteAccountWill',
      desc: '',
      args: [],
    );
  }

  /// `Delete all your personal information`
  String get deleteAllPersonalInfo {
    return Intl.message(
      'Delete all your personal information',
      name: 'deleteAllPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Delete all your uploaded information`
  String get deleteAllInfo {
    return Intl.message(
      'Delete all your uploaded information',
      name: 'deleteAllInfo',
      desc: '',
      args: [],
    );
  }

  /// `Delete all the information of your branches`
  String get deleteAllBranchInfo {
    return Intl.message(
      'Delete all the information of your branches',
      name: 'deleteAllBranchInfo',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email you registered with to receive the OTP code.\nThen enter the received code to delete your account`
  String get enterEmailToReceiveOtp {
    return Intl.message(
      'Enter the email you registered with to receive the OTP code.\nThen enter the received code to delete your account',
      name: 'enterEmailToReceiveOtp',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get plzEnterValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'plzEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send Delete Account Request`
  String get sendRequestDeleteAccount {
    return Intl.message(
      'Send Delete Account Request',
      name: 'sendRequestDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `OTP Code`
  String get otpCode {
    return Intl.message(
      'OTP Code',
      name: 'otpCode',
      desc: '',
      args: [],
    );
  }

  /// `Submit Code`
  String get submitCode {
    return Intl.message(
      'Submit Code',
      name: 'submitCode',
      desc: '',
      args: [],
    );
  }

  /// `Your Billing History`
  String get yourBillingHistory {
    return Intl.message(
      'Your Billing History',
      name: 'yourBillingHistory',
      desc: '',
      args: [],
    );
  }

  /// `Invoice No`
  String get invoiceNo {
    return Intl.message(
      'Invoice No',
      name: 'invoiceNo',
      desc: '',
      args: [],
    );
  }

  /// `Subscription date`
  String get subscriptionDate {
    return Intl.message(
      'Subscription date',
      name: 'subscriptionDate',
      desc: '',
      args: [],
    );
  }

  /// `Business Name`
  String get businessName {
    return Intl.message(
      'Business Name',
      name: 'businessName',
      desc: '',
      args: [],
    );
  }

  /// `Day Remains`
  String get dayRemains {
    return Intl.message(
      'Day Remains',
      name: 'dayRemains',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Renews`
  String get subscriptionRenews {
    return Intl.message(
      'Subscription Renews',
      name: 'subscriptionRenews',
      desc: '',
      args: [],
    );
  }

  /// `isActive`
  String get isActive {
    return Intl.message(
      'isActive',
      name: 'isActive',
      desc: '',
      args: [],
    );
  }

  /// `Checkout Summary`
  String get checkoutSummary {
    return Intl.message(
      'Checkout Summary',
      name: 'checkoutSummary',
      desc: '',
      args: [],
    );
  }

  /// `Store Name`
  String get branchName {
    return Intl.message(
      'Store Name',
      name: 'branchName',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// `Your {packageName} Subscription Plan`
  String selectedPlan(String packageName) {
    return Intl.message(
      'Your $packageName Subscription Plan',
      name: 'selectedPlan',
      desc: '',
      args: [packageName],
    );
  }

  /// `Features`
  String get features {
    return Intl.message(
      'Features',
      name: 'features',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Price Calculation`
  String get priceCalculation {
    return Intl.message(
      'Price Calculation',
      name: 'priceCalculation',
      desc: '',
      args: [],
    );
  }

  /// `Base Price`
  String get basePrice {
    return Intl.message(
      'Base Price',
      name: 'basePrice',
      desc: '',
      args: [],
    );
  }

  /// `Offer Type`
  String get offerType {
    return Intl.message(
      'Offer Type',
      name: 'offerType',
      desc: '',
      args: [],
    );
  }

  /// `Add-on Charges`
  String get addOnCharges {
    return Intl.message(
      'Add-on Charges',
      name: 'addOnCharges',
      desc: '',
      args: [],
    );
  }

  /// `Total price`
  String get totalPrice {
    return Intl.message(
      'Total price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `You have subscribed successfully!`
  String get subscribedSuccessfully {
    return Intl.message(
      'You have subscribed successfully!',
      name: 'subscribedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Select a Plan`
  String get selectPlan {
    return Intl.message(
      'Select a Plan',
      name: 'selectPlan',
      desc: '',
      args: [],
    );
  }

  /// `All plans above include:`
  String get allPlaneIncluded {
    return Intl.message(
      'All plans above include:',
      name: 'allPlaneIncluded',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get month {
    return Intl.message(
      'month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Choose {packageName} Plan`
  String choosePlan(String packageName) {
    return Intl.message(
      'Choose $packageName Plan',
      name: 'choosePlan',
      desc: '',
      args: [packageName],
    );
  }

  /// `Subscription Plane`
  String get subscriptionPlane {
    return Intl.message(
      'Subscription Plane',
      name: 'subscriptionPlane',
      desc: '',
      args: [],
    );
  }

  /// `Current Plan Details`
  String get currentPlanDetails {
    return Intl.message(
      'Current Plan Details',
      name: 'currentPlanDetails',
      desc: '',
      args: [],
    );
  }

  /// `Day Remaining`
  String get dayRemaining {
    return Intl.message(
      'Day Remaining',
      name: 'dayRemaining',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription has expired, please renew your subscription!`
  String get subscriptionExpired {
    return Intl.message(
      'Your subscription has expired, please renew your subscription!',
      name: 'subscriptionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Renew Plan`
  String get renewPlan {
    return Intl.message(
      'Renew Plan',
      name: 'renewPlan',
      desc: '',
      args: [],
    );
  }

  /// `Next Payment`
  String get nextPayment {
    return Intl.message(
      'Next Payment',
      name: 'nextPayment',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `You are on day {date} of your trial period`
  String trialPeriodRemainingDays(int date) {
    return Intl.message(
      'You are on day $date of your trial period',
      name: 'trialPeriodRemainingDays',
      desc: '',
      args: [date],
    );
  }

  /// `Add Stock`
  String get addStock {
    return Intl.message(
      'Add Stock',
      name: 'addStock',
      desc: '',
      args: [],
    );
  }

  /// `Edit Stock`
  String get editStock {
    return Intl.message(
      'Edit Stock',
      name: 'editStock',
      desc: '',
      args: [],
    );
  }

  /// `What are the stocks you are going to add?`
  String get whatStockAdd {
    return Intl.message(
      'What are the stocks you are going to add?',
      name: 'whatStockAdd',
      desc: '',
      args: [],
    );
  }

  /// `Add some stocks to be in place to\nensure a successful launch.`
  String get addSomeStocks {
    return Intl.message(
      'Add some stocks to be in place to\nensure a successful launch.',
      name: 'addSomeStocks',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message(
      'Import',
      name: 'import',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Name: `
  String get name {
    return Intl.message(
      'Name: ',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `items`
  String get items {
    return Intl.message(
      'items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Increase`
  String get increase {
    return Intl.message(
      'Increase',
      name: 'increase',
      desc: '',
      args: [],
    );
  }

  /// `Decrease`
  String get decrease {
    return Intl.message(
      'Decrease',
      name: 'decrease',
      desc: '',
      args: [],
    );
  }

  /// `Download Stock Report`
  String get downloadStockReport {
    return Intl.message(
      'Download Stock Report',
      name: 'downloadStockReport',
      desc: '',
      args: [],
    );
  }

  /// `Total Items`
  String get totalItems {
    return Intl.message(
      'Total Items',
      name: 'totalItems',
      desc: '',
      args: [],
    );
  }

  /// `Total Quantity`
  String get totalQuantity {
    return Intl.message(
      'Total Quantity',
      name: 'totalQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Total Product Value`
  String get totalProductValue {
    return Intl.message(
      'Total Product Value',
      name: 'totalProductValue',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message(
      'Sort by',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Decrease Stock Quantity`
  String get decreaseStockQuantity {
    return Intl.message(
      'Decrease Stock Quantity',
      name: 'decreaseStockQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Enter Quantity`
  String get enterQuantity {
    return Intl.message(
      'Enter Quantity',
      name: 'enterQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message(
      'Reason',
      name: 'reason',
      desc: '',
      args: [],
    );
  }

  /// `Stock quantity decreased successfully!`
  String get decreasedSuccessfully {
    return Intl.message(
      'Stock quantity decreased successfully!',
      name: 'decreasedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Increase Stock Quantity`
  String get increaseStockQuantity {
    return Intl.message(
      'Increase Stock Quantity',
      name: 'increaseStockQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Measure Unit`
  String get measureUnit {
    return Intl.message(
      'Measure Unit',
      name: 'measureUnit',
      desc: '',
      args: [],
    );
  }

  /// `Buying Price`
  String get buyingPrice {
    return Intl.message(
      'Buying Price',
      name: 'buyingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter Buying Price`
  String get enterBuyingPrice {
    return Intl.message(
      'Enter Buying Price',
      name: 'enterBuyingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Stock quantity increased successfully!`
  String get increasedSuccessfully {
    return Intl.message(
      'Stock quantity increased successfully!',
      name: 'increasedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Barcode Number, Product Name`
  String get barcodeNumProName {
    return Intl.message(
      'Barcode Number, Product Name',
      name: 'barcodeNumProName',
      desc: '',
      args: [],
    );
  }

  /// `Product English Name`
  String get proEnName {
    return Intl.message(
      'Product English Name',
      name: 'proEnName',
      desc: '',
      args: [],
    );
  }

  /// `Barcode Number`
  String get barcodeNumber {
    return Intl.message(
      'Barcode Number',
      name: 'barcodeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Current Quantity`
  String get currentQuantity {
    return Intl.message(
      'Current Quantity',
      name: 'currentQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Setup Guide For Your Business`
  String get stepGuideBusiness {
    return Intl.message(
      'Setup Guide For Your Business',
      name: 'stepGuideBusiness',
      desc: '',
      args: [],
    );
  }

  /// `This setup guide streamlines your business setup process for maximum ease and efficiency.`
  String get stepGuideBusinessDescription {
    return Intl.message(
      'This setup guide streamlines your business setup process for maximum ease and efficiency.',
      name: 'stepGuideBusinessDescription',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Business Type & Country`
  String get selectBusinessTypeAndCountry {
    return Intl.message(
      'Select Your Business Type & Country',
      name: 'selectBusinessTypeAndCountry',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Your Business Type & Country`
  String get pleaseSelectBusinessTypeAndCountry {
    return Intl.message(
      'Please Select Your Business Type & Country',
      name: 'pleaseSelectBusinessTypeAndCountry',
      desc: '',
      args: [],
    );
  }

  /// `By choosing your business type, we can customize your needs.`
  String get selectBusinessTypeDescription {
    return Intl.message(
      'By choosing your business type, we can customize your needs.',
      name: 'selectBusinessTypeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Business and Country`
  String get addBusinessAndCountry {
    return Intl.message(
      'Add Business and Country',
      name: 'addBusinessAndCountry',
      desc: '',
      args: [],
    );
  }

  /// `Configuration`
  String get configuration {
    return Intl.message(
      'Configuration',
      name: 'configuration',
      desc: '',
      args: [],
    );
  }

  /// `Enable or disable features according to your preference.`
  String get enableOrDisable {
    return Intl.message(
      'Enable or disable features according to your preference.',
      name: 'enableOrDisable',
      desc: '',
      args: [],
    );
  }

  /// `Change Configuration`
  String get changeConfiguration {
    return Intl.message(
      'Change Configuration',
      name: 'changeConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Upload products list`
  String get uploadProductsList {
    return Intl.message(
      'Upload products list',
      name: 'uploadProductsList',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notifications {
    return Intl.message(
      'Notification',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Notifications are sent to customers to inform them about order updates eg:- We have received our order.`
  String get notificationsDes {
    return Intl.message(
      'Notifications are sent to customers to inform them about order updates eg:- We have received our order.',
      name: 'notificationsDes',
      desc: '',
      args: [],
    );
  }

  /// `Add Notification`
  String get addNotification {
    return Intl.message(
      'Add Notification',
      name: 'addNotification',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `This field displays the maximum SMS balance limit that users can send to their clients, ensuring efficient communication and messaging capabilities.`
  String get notificationDes {
    return Intl.message(
      'This field displays the maximum SMS balance limit that users can send to their clients, ensuring efficient communication and messaging capabilities.',
      name: 'notificationDes',
      desc: '',
      args: [],
    );
  }

  /// `Add Notification`
  String get addSMS {
    return Intl.message(
      'Add Notification',
      name: 'addSMS',
      desc: '',
      args: [],
    );
  }

  /// `Edit SMS`
  String get editSMS {
    return Intl.message(
      'Edit SMS',
      name: 'editSMS',
      desc: '',
      args: [],
    );
  }

  /// `Setup Guide`
  String get setupGuide {
    return Intl.message(
      'Setup Guide',
      name: 'setupGuide',
      desc: '',
      args: [],
    );
  }

  /// `This setup guide is to make it as easy as possible for you to get start the store running.`
  String get setupGuideDes {
    return Intl.message(
      'This setup guide is to make it as easy as possible for you to get start the store running.',
      name: 'setupGuideDes',
      desc: '',
      args: [],
    );
  }

  /// `Add Your first product`
  String get addYourFirstProduct {
    return Intl.message(
      'Add Your first product',
      name: 'addYourFirstProduct',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image, Enter Product Name, Enter Price and Add Quantity.`
  String get addYourFirstProductDes {
    return Intl.message(
      'Upload Image, Enter Product Name, Enter Price and Add Quantity.',
      name: 'addYourFirstProductDes',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message(
      'Add Product',
      name: 'addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Add Your Stock`
  String get addYourStock {
    return Intl.message(
      'Add Your Stock',
      name: 'addYourStock',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image, Select Category, Select Product Name, Enter Manufacture and Expiry Date, Enter Batch No, Enter Price, and Add Quantity.`
  String get addYourStockDes {
    return Intl.message(
      'Upload Image, Select Category, Select Product Name, Enter Manufacture and Expiry Date, Enter Batch No, Enter Price, and Add Quantity.',
      name: 'addYourStockDes',
      desc: '',
      args: [],
    );
  }

  /// `Store Info`
  String get storeInfo {
    return Intl.message(
      'Store Info',
      name: 'storeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Merchant information here you can update the Logos for the Merchant Store, Merchant Name, Merchant Description, Email address, Location and the social media links.`
  String get merchantInfoDes {
    return Intl.message(
      'Merchant information here you can update the Logos for the Merchant Store, Merchant Name, Merchant Description, Email address, Location and the social media links.',
      name: 'merchantInfoDes',
      desc: '',
      args: [],
    );
  }

  /// `Add Info`
  String get addInfo {
    return Intl.message(
      'Add Info',
      name: 'addInfo',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get addUser {
    return Intl.message(
      'Add User',
      name: 'addUser',
      desc: '',
      args: [],
    );
  }

  /// `Add user to your store`
  String get addUserDes {
    return Intl.message(
      'Add user to your store',
      name: 'addUserDes',
      desc: '',
      args: [],
    );
  }

  /// `Add Device`
  String get addDevice {
    return Intl.message(
      'Add Device',
      name: 'addDevice',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Device serial No and IMEI No.`
  String get addDeviceDes {
    return Intl.message(
      'Enter your Device serial No and IMEI No.',
      name: 'addDeviceDes',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `Setup Guide is Completed`
  String get setupGuideCompleted {
    return Intl.message(
      'Setup Guide is Completed',
      name: 'setupGuideCompleted',
      desc: '',
      args: [],
    );
  }

  /// `All the process for the setup guide\nhas been completed`
  String get setupGuideCompletedDes {
    return Intl.message(
      'All the process for the setup guide\nhas been completed',
      name: 'setupGuideCompletedDes',
      desc: '',
      args: [],
    );
  }

  /// `Please wait while we\nsetup your account`
  String get plzWaitSetupAccount {
    return Intl.message(
      'Please wait while we\nsetup your account',
      name: 'plzWaitSetupAccount',
      desc: '',
      args: [],
    );
  }

  /// `This will take a moment...`
  String get willTakeMoment {
    return Intl.message(
      'This will take a moment...',
      name: 'willTakeMoment',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Event`
  String get event {
    return Intl.message(
      'Event',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get text {
    return Intl.message(
      'Text',
      name: 'text',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Business Type`
  String get businessType {
    return Intl.message(
      'Business Type',
      name: 'businessType',
      desc: '',
      args: [],
    );
  }

  /// `Select a Business Type`
  String get selectBusinessType {
    return Intl.message(
      'Select a Business Type',
      name: 'selectBusinessType',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Custom Catalogak Sub Domain`
  String get enterSubDomain {
    return Intl.message(
      'Enter Your Custom Catalogak Sub Domain',
      name: 'enterSubDomain',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Select a Country`
  String get selectCountry {
    return Intl.message(
      'Select a Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Select a city`
  String get selectCity {
    return Intl.message(
      'Select a city',
      name: 'selectCity',
      desc: '',
      args: [],
    );
  }

  /// `Business Address`
  String get businessAddress {
    return Intl.message(
      'Business Address',
      name: 'businessAddress',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your branch created successfully!`
  String get yourBranchCreatedSuccessfully {
    return Intl.message(
      'Your branch created successfully!',
      name: 'yourBranchCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded successfully`
  String get uploadedSuccessfully {
    return Intl.message(
      'Uploaded successfully',
      name: 'uploadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Download Templates`
  String get downloadTemplate {
    return Intl.message(
      'Download Templates',
      name: 'downloadTemplate',
      desc: '',
      args: [],
    );
  }

  /// `Update Product List`
  String get updateProductList {
    return Intl.message(
      'Update Product List',
      name: 'updateProductList',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for signing up!`
  String get thankForSignUp {
    return Intl.message(
      'Thanks for signing up!',
      name: 'thankForSignUp',
      desc: '',
      args: [],
    );
  }

  /// `We will help you get started\nwith just a couple of steps with the help of our guide.`
  String get helpToGetStart {
    return Intl.message(
      'We will help you get started\nwith just a couple of steps with the help of our guide.',
      name: 'helpToGetStart',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Contact us `
  String get contactUs {
    return Intl.message(
      'Contact us ',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `today`
  String get today {
    return Intl.message(
      'today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Call us: `
  String get callUs {
    return Intl.message(
      'Call us: ',
      name: 'callUs',
      desc: '',
      args: [],
    );
  }

  /// `Address: `
  String get address {
    return Intl.message(
      'Address: ',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Morning`
  String get morning {
    return Intl.message(
      'Morning',
      name: 'morning',
      desc: '',
      args: [],
    );
  }

  /// `AfterNoon`
  String get afterNoon {
    return Intl.message(
      'AfterNoon',
      name: 'afterNoon',
      desc: '',
      args: [],
    );
  }

  /// `Evening`
  String get evening {
    return Intl.message(
      'Evening',
      name: 'evening',
      desc: '',
      args: [],
    );
  }

  /// `Service with a `
  String get serviceWith {
    return Intl.message(
      'Service with a ',
      name: 'serviceWith',
      desc: '',
      args: [],
    );
  }

  /// `The right fit for your business`
  String get theRightFit {
    return Intl.message(
      'The right fit for your business',
      name: 'theRightFit',
      desc: '',
      args: [],
    );
  }

  /// `New to Point of Sales (POS)? We take the time to help you\nunderstand how it all works so you can make the best\ndecisions for your business.`
  String get helpPOS {
    return Intl.message(
      'New to Point of Sales (POS)? We take the time to help you\nunderstand how it all works so you can make the best\ndecisions for your business.',
      name: 'helpPOS',
      desc: '',
      args: [],
    );
  }

  /// `Speak to real person`
  String get speakToRealPerson {
    return Intl.message(
      'Speak to real person',
      name: 'speakToRealPerson',
      desc: '',
      args: [],
    );
  }

  /// `Get help fast`
  String get getHelpFast {
    return Intl.message(
      'Get help fast',
      name: 'getHelpFast',
      desc: '',
      args: [],
    );
  }

  /// `Experts you can trust`
  String get expertsTrust {
    return Intl.message(
      'Experts you can trust',
      name: 'expertsTrust',
      desc: '',
      args: [],
    );
  }

  /// `Have us contact`
  String get haveUsContact {
    return Intl.message(
      'Have us contact',
      name: 'haveUsContact',
      desc: '',
      args: [],
    );
  }

  /// `you.`
  String get you {
    return Intl.message(
      'you.',
      name: 'you',
      desc: '',
      args: [],
    );
  }

  /// `Contact Name`
  String get contactName {
    return Intl.message(
      'Contact Name',
      name: 'contactName',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Time Preference`
  String get timePreference {
    return Intl.message(
      'Time Preference',
      name: 'timePreference',
      desc: '',
      args: [],
    );
  }

  /// `I need Support`
  String get needSupport {
    return Intl.message(
      'I need Support',
      name: 'needSupport',
      desc: '',
      args: [],
    );
  }

  /// `If you need to setup the merchant app\nwith the help of support please click the button below.`
  String get setupWithSupport {
    return Intl.message(
      'If you need to setup the merchant app\nwith the help of support please click the button below.',
      name: 'setupWithSupport',
      desc: '',
      args: [],
    );
  }

  /// `I will setup myself`
  String get setupMySelf {
    return Intl.message(
      'I will setup myself',
      name: 'setupMySelf',
      desc: '',
      args: [],
    );
  }

  /// `Your changes updated successfully!`
  String get changesUpdateSuccessfully {
    return Intl.message(
      'Your changes updated successfully!',
      name: 'changesUpdateSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Customer address will be required`
  String get customerAddressRequired {
    return Intl.message(
      'Customer address will be required',
      name: 'customerAddressRequired',
      desc: '',
      args: [],
    );
  }

  /// `This feature ensures that customer addresses are collected and required for order processing, facilitating accurate and efficient delivery.`
  String get customerAddressRequiredTooltip {
    return Intl.message(
      'This feature ensures that customer addresses are collected and required for order processing, facilitating accurate and efficient delivery.',
      name: 'customerAddressRequiredTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Order via whatsapp`
  String get orderViaWhatsapp {
    return Intl.message(
      'Order via whatsapp',
      name: 'orderViaWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Send online store order to WhatsApp number when enabled`
  String get orderViaWhatsappTooltip {
    return Intl.message(
      'Send online store order to WhatsApp number when enabled',
      name: 'orderViaWhatsappTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Param 1`
  String get param1 {
    return Intl.message(
      'Param 1',
      name: 'param1',
      desc: '',
      args: [],
    );
  }

  /// `Param 2`
  String get param2 {
    return Intl.message(
      'Param 2',
      name: 'param2',
      desc: '',
      args: [],
    );
  }

  /// `Param 3`
  String get param3 {
    return Intl.message(
      'Param 3',
      name: 'param3',
      desc: '',
      args: [],
    );
  }

  /// `Update successfully`
  String get updatedSuccessfully {
    return Intl.message(
      'Update successfully',
      name: 'updatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message(
      'Enable',
      name: 'enable',
      desc: '',
      args: [],
    );
  }

  /// `Disable`
  String get disable {
    return Intl.message(
      'Disable',
      name: 'disable',
      desc: '',
      args: [],
    );
  }

  /// `Enable Queue in the system allowing generation of queue # before invoicing.`
  String get manageCustomerOrderAndLines {
    return Intl.message(
      'Enable Queue in the system allowing generation of queue # before invoicing.',
      name: 'manageCustomerOrderAndLines',
      desc: '',
      args: [],
    );
  }

  /// `Queue`
  String get queue {
    return Intl.message(
      'Queue',
      name: 'queue',
      desc: '',
      args: [],
    );
  }

  /// `SMS Notification: `
  String get smsAllowed {
    return Intl.message(
      'SMS Notification: ',
      name: 'smsAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Customer Management`
  String get customerManagement {
    return Intl.message(
      'Customer Management',
      name: 'customerManagement',
      desc: '',
      args: [],
    );
  }

  /// `The cashier can easily add or select a customer during a transaction, streamlining the checkout process and enabling quick access to customer information and rewards.`
  String get customerAllowedTooltip {
    return Intl.message(
      'The cashier can easily add or select a customer during a transaction, streamlining the checkout process and enabling quick access to customer information and rewards.',
      name: 'customerAllowedTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Manage discounts and promotions alerts for your customers.`
  String get managerDiscount {
    return Intl.message(
      'Manage discounts and promotions alerts for your customers.',
      name: 'managerDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Discount Type`
  String get discountType {
    return Intl.message(
      'Discount Type',
      name: 'discountType',
      desc: '',
      args: [],
    );
  }

  /// `Enabling the sales return option in the system allowing user to raise a request of sales return of a specific sale record. Automatic allow a sales return to be done in the system without the requirement of the approvals.`
  String get processCustomerOrder {
    return Intl.message(
      'Enabling the sales return option in the system allowing user to raise a request of sales return of a specific sale record. Automatic allow a sales return to be done in the system without the requirement of the approvals.',
      name: 'processCustomerOrder',
      desc: '',
      args: [],
    );
  }

  /// `Cash field allow user to pay by using cash. Visa field allow user to pay by visa card (Bank Account). Multi Cheque is to pay by cheque. When merchant try to make transaction the password he has to enter the password.`
  String get acceptVariousPayment {
    return Intl.message(
      'Cash field allow user to pay by using cash. Visa field allow user to pay by visa card (Bank Account). Multi Cheque is to pay by cheque. When merchant try to make transaction the password he has to enter the password.',
      name: 'acceptVariousPayment',
      desc: '',
      args: [],
    );
  }

  /// `Printing`
  String get printing {
    return Intl.message(
      'Printing',
      name: 'printing',
      desc: '',
      args: [],
    );
  }

  /// `Printing Allow`
  String get printingAllow {
    return Intl.message(
      'Printing Allow',
      name: 'printingAllow',
      desc: '',
      args: [],
    );
  }

  /// `Reprint`
  String get reprint {
    return Intl.message(
      'Reprint',
      name: 'reprint',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Copy`
  String get merchantCopy {
    return Intl.message(
      'Merchant Copy',
      name: 'merchantCopy',
      desc: '',
      args: [],
    );
  }

  /// `Footer Message`
  String get footerMsg {
    return Intl.message(
      'Footer Message',
      name: 'footerMsg',
      desc: '',
      args: [],
    );
  }

  /// `Select a Tax Type`
  String get selectTaxType {
    return Intl.message(
      'Select a Tax Type',
      name: 'selectTaxType',
      desc: '',
      args: [],
    );
  }

  /// `Tax Type`
  String get taxType {
    return Intl.message(
      'Tax Type',
      name: 'taxType',
      desc: '',
      args: [],
    );
  }

  /// `Tax Value`
  String get taxValue {
    return Intl.message(
      'Tax Value',
      name: 'taxValue',
      desc: '',
      args: [],
    );
  }

  /// `Select a refund mode`
  String get selectClaimMod {
    return Intl.message(
      'Select a refund mode',
      name: 'selectClaimMod',
      desc: '',
      args: [],
    );
  }

  /// `Select a merchant copy`
  String get selectMerchantCopy {
    return Intl.message(
      'Select a merchant copy',
      name: 'selectMerchantCopy',
      desc: '',
      args: [],
    );
  }

  /// `Select a payment mode`
  String get selectPaymentMode {
    return Intl.message(
      'Select a payment mode',
      name: 'selectPaymentMode',
      desc: '',
      args: [],
    );
  }

  /// `Select a tax`
  String get selectTax {
    return Intl.message(
      'Select a tax',
      name: 'selectTax',
      desc: '',
      args: [],
    );
  }

  /// `Enter TRN value`
  String get enterTRNValue {
    return Intl.message(
      'Enter TRN value',
      name: 'enterTRNValue',
      desc: '',
      args: [],
    );
  }

  /// `Enter Footer value`
  String get enterFooterValue {
    return Intl.message(
      'Enter Footer value',
      name: 'enterFooterValue',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `Search by category name`
  String get searchByCategoryName {
    return Intl.message(
      'Search by category name',
      name: 'searchByCategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Please Select a Main Category and a Sub Category.`
  String get plzSelectMainAndSub {
    return Intl.message(
      'Please Select a Main Category and a Sub Category.',
      name: 'plzSelectMainAndSub',
      desc: '',
      args: [],
    );
  }

  /// `All items`
  String get allItems {
    return Intl.message(
      'All items',
      name: 'allItems',
      desc: '',
      args: [],
    );
  }

  /// `onlyActiveItems`
  String get onlyActiveItems {
    return Intl.message(
      'onlyActiveItems',
      name: 'onlyActiveItems',
      desc: '',
      args: [],
    );
  }

  /// `Search by name or barcode number`
  String get searchByNameOrBarcode {
    return Intl.message(
      'Search by name or barcode number',
      name: 'searchByNameOrBarcode',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get list {
    return Intl.message(
      'List',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `Grid`
  String get gird {
    return Intl.message(
      'Grid',
      name: 'gird',
      desc: '',
      args: [],
    );
  }

  /// `What are the products you are going to sell?`
  String get whatProductSell {
    return Intl.message(
      'What are the products you are going to sell?',
      name: 'whatProductSell',
      desc: '',
      args: [],
    );
  }

  /// `Prior to launching your store, you will require some products to be in place to ensure a successful launch.`
  String get someProductRequired {
    return Intl.message(
      'Prior to launching your store, you will require some products to be in place to ensure a successful launch.',
      name: 'someProductRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please select a category`
  String get plzSelectCategory {
    return Intl.message(
      'Please select a category',
      name: 'plzSelectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Add Sub-Category`
  String get addSubCategory {
    return Intl.message(
      'Add Sub-Category',
      name: 'addSubCategory',
      desc: '',
      args: [],
    );
  }

  /// `Search by sub-category name`
  String get searchBySubNme {
    return Intl.message(
      'Search by sub-category name',
      name: 'searchBySubNme',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category`
  String get subcategory {
    return Intl.message(
      'Sub Category',
      name: 'subcategory',
      desc: '',
      args: [],
    );
  }

  /// `Sub`
  String get sub {
    return Intl.message(
      'Sub',
      name: 'sub',
      desc: '',
      args: [],
    );
  }

  /// `Category’s English Name`
  String get catEngName {
    return Intl.message(
      'Category’s English Name',
      name: 'catEngName',
      desc: '',
      args: [],
    );
  }

  /// `Category’s French Name`
  String get catFrenchName {
    return Intl.message(
      'Category’s French Name',
      name: 'catFrenchName',
      desc: '',
      args: [],
    );
  }

  /// `Category’s Arabic Name`
  String get catArName {
    return Intl.message(
      'Category’s Arabic Name',
      name: 'catArName',
      desc: '',
      args: [],
    );
  }

  /// `Category’s Turkish Name`
  String get catTrName {
    return Intl.message(
      'Category’s Turkish Name',
      name: 'catTrName',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category’s English Name`
  String get subCatEngName {
    return Intl.message(
      'Sub Category’s English Name',
      name: 'subCatEngName',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category’s French Name`
  String get subCatFrenchName {
    return Intl.message(
      'Sub Category’s French Name',
      name: 'subCatFrenchName',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category’s Arabic Name`
  String get subCatArName {
    return Intl.message(
      'Sub Category’s Arabic Name',
      name: 'subCatArName',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category’s Turkish Name`
  String get subCatTrName {
    return Intl.message(
      'Sub Category’s Turkish Name',
      name: 'subCatTrName',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadImage {
    return Intl.message(
      'Upload Image',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Product Description`
  String get productDes {
    return Intl.message(
      'Product Description',
      name: 'productDes',
      desc: '',
      args: [],
    );
  }

  /// `Product’s English Name`
  String get productEngName {
    return Intl.message(
      'Product’s English Name',
      name: 'productEngName',
      desc: '',
      args: [],
    );
  }

  /// `Product’s French Name`
  String get productFrenchName {
    return Intl.message(
      'Product’s French Name',
      name: 'productFrenchName',
      desc: '',
      args: [],
    );
  }

  /// `Product’s Arabic Name`
  String get productArName {
    return Intl.message(
      'Product’s Arabic Name',
      name: 'productArName',
      desc: '',
      args: [],
    );
  }

  /// `Product’s Turkish Name`
  String get productTrName {
    return Intl.message(
      'Product’s Turkish Name',
      name: 'productTrName',
      desc: '',
      args: [],
    );
  }

  /// `Save Product`
  String get saveProduct {
    return Intl.message(
      'Save Product',
      name: 'saveProduct',
      desc: '',
      args: [],
    );
  }

  /// `Discount price cannot be greater than price.`
  String get discountPriceCannotBeGreaterThanPrice {
    return Intl.message(
      'Discount price cannot be greater than price.',
      name: 'discountPriceCannotBeGreaterThanPrice',
      desc: '',
      args: [],
    );
  }

  /// `Select a type`
  String get selectType {
    return Intl.message(
      'Select a type',
      name: 'selectType',
      desc: '',
      args: [],
    );
  }

  /// `Select a subcategory`
  String get selectSubCategory {
    return Intl.message(
      'Select a subcategory',
      name: 'selectSubCategory',
      desc: '',
      args: [],
    );
  }

  /// `Enter the price`
  String get enterPrice {
    return Intl.message(
      'Enter the price',
      name: 'enterPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter the minimum and maximum price`
  String get enterMinimumAndMaximumPrice {
    return Intl.message(
      'Enter the minimum and maximum price',
      name: 'enterMinimumAndMaximumPrice',
      desc: '',
      args: [],
    );
  }

  /// `Open Price`
  String get openPrice {
    return Intl.message(
      'Open Price',
      name: 'openPrice',
      desc: '',
      args: [],
    );
  }

  /// `Open Quantity`
  String get openQuantity {
    return Intl.message(
      'Open Quantity',
      name: 'openQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Can Have Stock`
  String get canHaveStock {
    return Intl.message(
      'Can Have Stock',
      name: 'canHaveStock',
      desc: '',
      args: [],
    );
  }

  /// `Initial Quantity`
  String get initialQuantity {
    return Intl.message(
      'Initial Quantity',
      name: 'initialQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Price`
  String get maximumPrice {
    return Intl.message(
      'Maximum Price',
      name: 'maximumPrice',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Price`
  String get minimumPrice {
    return Intl.message(
      'Minimum Price',
      name: 'minimumPrice',
      desc: '',
      args: [],
    );
  }

  /// `Product Discount`
  String get productDiscount {
    return Intl.message(
      'Product Discount',
      name: 'productDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `The buying price is higher than the price, Do you want to submit your data?`
  String get buyingPriceHigherThanPrice {
    return Intl.message(
      'The buying price is higher than the price, Do you want to submit your data?',
      name: 'buyingPriceHigherThanPrice',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get orderId {
    return Intl.message(
      'Order ID',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get created {
    return Intl.message(
      'Created',
      name: 'created',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Number of Orders (Today)`
  String get numberOfOrdersToday {
    return Intl.message(
      'Number of Orders (Today)',
      name: 'numberOfOrdersToday',
      desc: '',
      args: [],
    );
  }

  /// `Order Amount (Today)`
  String get salesAmountToday {
    return Intl.message(
      'Order Amount (Today)',
      name: 'salesAmountToday',
      desc: '',
      args: [],
    );
  }

  /// `Number of Products (Today)`
  String get numberOfProductToday {
    return Intl.message(
      'Number of Products (Today)',
      name: 'numberOfProductToday',
      desc: '',
      args: [],
    );
  }

  /// `Number of Customers (Today)`
  String get numberOfCustomerToday {
    return Intl.message(
      'Number of Customers (Today)',
      name: 'numberOfCustomerToday',
      desc: '',
      args: [],
    );
  }

  /// `Select the cashier:`
  String get selectCashier {
    return Intl.message(
      'Select the cashier:',
      name: 'selectCashier',
      desc: '',
      args: [],
    );
  }

  /// `Select the payment type for this order:`
  String get selectPaymentForThisOrder {
    return Intl.message(
      'Select the payment type for this order:',
      name: 'selectPaymentForThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please enter all fields`
  String get plzEnterAllField {
    return Intl.message(
      'Please enter all fields',
      name: 'plzEnterAllField',
      desc: '',
      args: [],
    );
  }

  /// `Change Status`
  String get changeStatus {
    return Intl.message(
      'Change Status',
      name: 'changeStatus',
      desc: '',
      args: [],
    );
  }

  /// `Store Name`
  String get storeName {
    return Intl.message(
      'Store Name',
      name: 'storeName',
      desc: '',
      args: [],
    );
  }

  /// `Contact Number`
  String get contactNumber {
    return Intl.message(
      'Contact Number',
      name: 'contactNumber',
      desc: '',
      args: [],
    );
  }

  /// `Second Phone Number`
  String get secondPhone {
    return Intl.message(
      'Second Phone Number',
      name: 'secondPhone',
      desc: '',
      args: [],
    );
  }

  /// `Branch Description`
  String get branchDesc {
    return Intl.message(
      'Branch Description',
      name: 'branchDesc',
      desc: '',
      args: [],
    );
  }

  /// `Facebook Link`
  String get facebookLink {
    return Intl.message(
      'Facebook Link',
      name: 'facebookLink',
      desc: '',
      args: [],
    );
  }

  /// `Instagram Link`
  String get instagramLink {
    return Intl.message(
      'Instagram Link',
      name: 'instagramLink',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp`
  String get whatsapp {
    return Intl.message(
      'Whatsapp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Placeholder logo`
  String get defaultLogo {
    return Intl.message(
      'Placeholder logo',
      name: 'defaultLogo',
      desc: '',
      args: [],
    );
  }

  /// `Store Logo`
  String get logo {
    return Intl.message(
      'Store Logo',
      name: 'logo',
      desc: '',
      args: [],
    );
  }

  /// `Footer logo`
  String get footerLogo {
    return Intl.message(
      'Footer logo',
      name: 'footerLogo',
      desc: '',
      args: [],
    );
  }

  /// `Logo printing`
  String get logoPrinting {
    return Intl.message(
      'Logo printing',
      name: 'logoPrinting',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want\nto remove the {logoName}`
  String removeConfirm(String logoName) {
    return Intl.message(
      'Are you sure you want\nto remove the $logoName',
      name: 'removeConfirm',
      desc: '',
      args: [logoName],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Edit Expense`
  String get editExpense {
    return Intl.message(
      'Edit Expense',
      name: 'editExpense',
      desc: '',
      args: [],
    );
  }

  /// `Add Expense`
  String get addExpense {
    return Intl.message(
      'Add Expense',
      name: 'addExpense',
      desc: '',
      args: [],
    );
  }

  /// `Expense Amount`
  String get expenseAmount {
    return Intl.message(
      'Expense Amount',
      name: 'expenseAmount',
      desc: '',
      args: [],
    );
  }

  /// `Enter the Amount for the Expense`
  String get enterTheAmountExpense {
    return Intl.message(
      'Enter the Amount for the Expense',
      name: 'enterTheAmountExpense',
      desc: '',
      args: [],
    );
  }

  /// `Expense Date`
  String get expenseDate {
    return Intl.message(
      'Expense Date',
      name: 'expenseDate',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Enter Notes here`
  String get enterNotesHere {
    return Intl.message(
      'Enter Notes here',
      name: 'enterNotesHere',
      desc: '',
      args: [],
    );
  }

  /// `Type of Expenses`
  String get typeOfExpense {
    return Intl.message(
      'Type of Expenses',
      name: 'typeOfExpense',
      desc: '',
      args: [],
    );
  }

  /// `Select the Expense Type`
  String get selectTheExpenseType {
    return Intl.message(
      'Select the Expense Type',
      name: 'selectTheExpenseType',
      desc: '',
      args: [],
    );
  }

  /// `Upload Invoice`
  String get uploadInvoice {
    return Intl.message(
      'Upload Invoice',
      name: 'uploadInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Payment Mode`
  String get paymentMode {
    return Intl.message(
      'Payment Mode',
      name: 'paymentMode',
      desc: '',
      args: [],
    );
  }

  /// `Type Name`
  String get typeName {
    return Intl.message(
      'Type Name',
      name: 'typeName',
      desc: '',
      args: [],
    );
  }

  /// `Add Type of Expense`
  String get addTypeOfExpense {
    return Intl.message(
      'Add Type of Expense',
      name: 'addTypeOfExpense',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name of Type of Expense`
  String get enterNameOfType {
    return Intl.message(
      'Enter Name of Type of Expense',
      name: 'enterNameOfType',
      desc: '',
      args: [],
    );
  }

  /// `Choose File`
  String get chooseFile {
    return Intl.message(
      'Choose File',
      name: 'chooseFile',
      desc: '',
      args: [],
    );
  }

  /// `No File Chosen`
  String get noFileChosen {
    return Intl.message(
      'No File Chosen',
      name: 'noFileChosen',
      desc: '',
      args: [],
    );
  }

  /// `Search by Type Name, Note, Amount`
  String get searchByNameNoteAmount {
    return Intl.message(
      'Search by Type Name, Note, Amount',
      name: 'searchByNameNoteAmount',
      desc: '',
      args: [],
    );
  }

  /// `Device`
  String get device {
    return Intl.message(
      'Device',
      name: 'device',
      desc: '',
      args: [],
    );
  }

  /// `Serial No`
  String get serialNo {
    return Intl.message(
      'Serial No',
      name: 'serialNo',
      desc: '',
      args: [],
    );
  }

  /// `Find the Serial Number back of the device`
  String get findSerialNo {
    return Intl.message(
      'Find the Serial Number back of the device',
      name: 'findSerialNo',
      desc: '',
      args: [],
    );
  }

  /// `Date Range`
  String get dateRange {
    return Intl.message(
      'Date Range',
      name: 'dateRange',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Edit Catalogak Sub Domain`
  String get editSubDomain {
    return Intl.message(
      'Edit Catalogak Sub Domain',
      name: 'editSubDomain',
      desc: '',
      args: [],
    );
  }

  /// `Top Ordered Per`
  String get topOrderProducts {
    return Intl.message(
      'Top Ordered Per',
      name: 'topOrderProducts',
      desc: '',
      args: [],
    );
  }

  /// `Top Sales Per`
  String get topSalesPer {
    return Intl.message(
      'Top Sales Per',
      name: 'topSalesPer',
      desc: '',
      args: [],
    );
  }

  /// `Based on Price`
  String get basedOnPrice {
    return Intl.message(
      'Based on Price',
      name: 'basedOnPrice',
      desc: '',
      args: [],
    );
  }

  /// `Based on Quantity`
  String get basedOnQuantity {
    return Intl.message(
      'Based on Quantity',
      name: 'basedOnQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `Order No`
  String get orderNo {
    return Intl.message(
      'Order No',
      name: 'orderNo',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Cashier Sales:`
  String get cashierSales {
    return Intl.message(
      'Cashier Sales:',
      name: 'cashierSales',
      desc: '',
      args: [],
    );
  }

  /// `Sales Per`
  String get salesPer {
    return Intl.message(
      'Sales Per',
      name: 'salesPer',
      desc: '',
      args: [],
    );
  }

  /// `Total Sales`
  String get totalSales {
    return Intl.message(
      'Total Sales',
      name: 'totalSales',
      desc: '',
      args: [],
    );
  }

  /// `Total Orders`
  String get totalOrders {
    return Intl.message(
      'Total Orders',
      name: 'totalOrders',
      desc: '',
      args: [],
    );
  }

  /// `Worker Sales:`
  String get workerSales {
    return Intl.message(
      'Worker Sales:',
      name: 'workerSales',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer`
  String get addCustomer {
    return Intl.message(
      'Add Customer',
      name: 'addCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Edit Customer`
  String get editCustomer {
    return Intl.message(
      'Edit Customer',
      name: 'editCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Search Customer`
  String get searchCustomer {
    return Intl.message(
      'Search Customer',
      name: 'searchCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Customer Name`
  String get customerName {
    return Intl.message(
      'Customer Name',
      name: 'customerName',
      desc: '',
      args: [],
    );
  }

  /// `Customer Email`
  String get customerEmail {
    return Intl.message(
      'Customer Email',
      name: 'customerEmail',
      desc: '',
      args: [],
    );
  }

  /// `Customer Address`
  String get customerAddress {
    return Intl.message(
      'Customer Address',
      name: 'customerAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer to your merchant app to store their,\ninformation and provide personalized services.`
  String get addCustomerDesc {
    return Intl.message(
      'Add Customer to your merchant app to store their,\ninformation and provide personalized services.',
      name: 'addCustomerDesc',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get district {
    return Intl.message(
      'District',
      name: 'district',
      desc: '',
      args: [],
    );
  }

  /// `Flat`
  String get flat {
    return Intl.message(
      'Flat',
      name: 'flat',
      desc: '',
      args: [],
    );
  }

  /// `Building Name`
  String get buildName {
    return Intl.message(
      'Building Name',
      name: 'buildName',
      desc: '',
      args: [],
    );
  }

  /// `Additional Information`
  String get additionalInfo {
    return Intl.message(
      'Additional Information',
      name: 'additionalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Add Operator`
  String get addCashier {
    return Intl.message(
      'Add Operator',
      name: 'addCashier',
      desc: '',
      args: [],
    );
  }

  /// `Edit Operator`
  String get editCashier {
    return Intl.message(
      'Edit Operator',
      name: 'editCashier',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `Adding a user can help ensure efficient transactions.`
  String get addUserDesTran {
    return Intl.message(
      'Adding a user can help ensure efficient transactions.',
      name: 'addUserDesTran',
      desc: '',
      args: [],
    );
  }

  /// `Adding a user to inventory can streamline the sales process,\nimprove customer service, and help to keep track of inventory levels in real-time.`
  String get addUserDesStock {
    return Intl.message(
      'Adding a user to inventory can streamline the sales process,\nimprove customer service, and help to keep track of inventory levels in real-time.',
      name: 'addUserDesStock',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Select Range of Date`
  String get selectDateRange {
    return Intl.message(
      'Select Range of Date',
      name: 'selectDateRange',
      desc: '',
      args: [],
    );
  }

  /// `Select a valid excel file`
  String get selectValidExcelFile {
    return Intl.message(
      'Select a valid excel file',
      name: 'selectValidExcelFile',
      desc: '',
      args: [],
    );
  }

  /// `Drop excel file here`
  String get DropExcelFile {
    return Intl.message(
      'Drop excel file here',
      name: 'DropExcelFile',
      desc: '',
      args: [],
    );
  }

  /// `this field is required`
  String get thisFieldRequired {
    return Intl.message(
      'this field is required',
      name: 'thisFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Import Product`
  String get importProduct {
    return Intl.message(
      'Import Product',
      name: 'importProduct',
      desc: '',
      args: [],
    );
  }

  /// `Download a `
  String get downloadA {
    return Intl.message(
      'Download a ',
      name: 'downloadA',
      desc: '',
      args: [],
    );
  }

  /// `sample CSV Template`
  String get csvTemp {
    return Intl.message(
      'sample CSV Template',
      name: 'csvTemp',
      desc: '',
      args: [],
    );
  }

  /// `Publish new products to all branches.`
  String get publishNewPro {
    return Intl.message(
      'Publish new products to all branches.',
      name: 'publishNewPro',
      desc: '',
      args: [],
    );
  }

  /// `If there are any existing products with the same details, please replace them with the new products.`
  String get replaceProduct {
    return Intl.message(
      'If there are any existing products with the same details, please replace them with the new products.',
      name: 'replaceProduct',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Product Listing`
  String get productListing {
    return Intl.message(
      'Product Listing',
      name: 'productListing',
      desc: '',
      args: [],
    );
  }

  /// `Item Listing`
  String get itemListing {
    return Intl.message(
      'Item Listing',
      name: 'itemListing',
      desc: '',
      args: [],
    );
  }

  /// `Tables Management`
  String get tablesManagement {
    return Intl.message(
      'Tables Management',
      name: 'tablesManagement',
      desc: '',
      args: [],
    );
  }

  /// `Order Management`
  String get orderManagement {
    return Intl.message(
      'Order Management',
      name: 'orderManagement',
      desc: '',
      args: [],
    );
  }

  /// `Stock`
  String get stock {
    return Intl.message(
      'Stock',
      name: 'stock',
      desc: '',
      args: [],
    );
  }

  /// `Support And Privacy`
  String get supportAndPrivacy {
    return Intl.message(
      'Support And Privacy',
      name: 'supportAndPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get expense {
    return Intl.message(
      'Expenses',
      name: 'expense',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `Cashiers`
  String get cashiers {
    return Intl.message(
      'Cashiers',
      name: 'cashiers',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forgetPass {
    return Intl.message(
      'Forget password?',
      name: 'forgetPass',
      desc: '',
      args: [],
    );
  }

  /// `username and password is required`
  String get userNameAdPassRequired {
    return Intl.message(
      'username and password is required',
      name: 'userNameAdPassRequired',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up here`
  String get signUpHere {
    return Intl.message(
      'Sign up here',
      name: 'signUpHere',
      desc: '',
      args: [],
    );
  }

  /// `Already an existing user? `
  String get alreadyExisting {
    return Intl.message(
      'Already an existing user? ',
      name: 'alreadyExisting',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `UserName is required`
  String get userNameIsRequired {
    return Intl.message(
      'UserName is required',
      name: 'userNameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Congratulation!`
  String get congratulation {
    return Intl.message(
      'Congratulation!',
      name: 'congratulation',
      desc: '',
      args: [],
    );
  }

  /// `Registration has been completed.\nYour credentials have been sent to your email.`
  String get registrationCompleted {
    return Intl.message(
      'Registration has been completed.\nYour credentials have been sent to your email.',
      name: 'registrationCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email you registered with to receive the OTP code.\nThen enter the received code and you new desired password`
  String get enterEmailToSendOtp {
    return Intl.message(
      'Enter the email you registered with to receive the OTP code.\nThen enter the received code and you new desired password',
      name: 'enterEmailToSendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Send Change Password Request`
  String get sendChangePassRequest {
    return Intl.message(
      'Send Change Password Request',
      name: 'sendChangePassRequest',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePass {
    return Intl.message(
      'Change Password',
      name: 'changePass',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPass {
    return Intl.message(
      'New Password',
      name: 'newPass',
      desc: '',
      args: [],
    );
  }

  /// `Reference Number`
  String get referenceID {
    return Intl.message(
      'Reference Number',
      name: 'referenceID',
      desc: '',
      args: [],
    );
  }

  /// `Enter Reference Number for transaction`
  String get enterReferenceID {
    return Intl.message(
      'Enter Reference Number for transaction',
      name: 'enterReferenceID',
      desc: '',
      args: [],
    );
  }

  /// `Cashiers Reports`
  String get reportsByCashiers {
    return Intl.message(
      'Cashiers Reports',
      name: 'reportsByCashiers',
      desc: '',
      args: [],
    );
  }

  /// `SubCategories Reports`
  String get reportsBySubCategory {
    return Intl.message(
      'SubCategories Reports',
      name: 'reportsBySubCategory',
      desc: '',
      args: [],
    );
  }

  /// `Products Reports`
  String get reportsByProducts {
    return Intl.message(
      'Products Reports',
      name: 'reportsByProducts',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Business Hours`
  String get businessHours {
    return Intl.message(
      'Business Hours',
      name: 'businessHours',
      desc: '',
      args: [],
    );
  }

  /// `Add Exception`
  String get addException {
    return Intl.message(
      'Add Exception',
      name: 'addException',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get defaultBusinessHoursType {
    return Intl.message(
      'Default',
      name: 'defaultBusinessHoursType',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get deliveryBusinessHoursType {
    return Intl.message(
      'Delivery',
      name: 'deliveryBusinessHoursType',
      desc: '',
      args: [],
    );
  }

  /// `Pick up`
  String get pickupBusinessHoursType {
    return Intl.message(
      'Pick up',
      name: 'pickupBusinessHoursType',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get bookingBusinessHoursType {
    return Intl.message(
      'Booking',
      name: 'bookingBusinessHoursType',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Manage Add-on items`
  String get manageAddOnItems {
    return Intl.message(
      'Manage Add-on items',
      name: 'manageAddOnItems',
      desc: '',
      args: [],
    );
  }

  /// `Customer Type`
  String get customerType {
    return Intl.message(
      'Customer Type',
      name: 'customerType',
      desc: '',
      args: [],
    );
  }

  /// `Credit Balance`
  String get creditBalance {
    return Intl.message(
      'Credit Balance',
      name: 'creditBalance',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History`
  String get transactionHistory {
    return Intl.message(
      'Transaction History',
      name: 'transactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `View Customer Information`
  String get viewCustomerInformation {
    return Intl.message(
      'View Customer Information',
      name: 'viewCustomerInformation',
      desc: '',
      args: [],
    );
  }

  /// `Customer Information`
  String get customerInformation {
    return Intl.message(
      'Customer Information',
      name: 'customerInformation',
      desc: '',
      args: [],
    );
  }

  /// `Create a Payment`
  String get createPayment {
    return Intl.message(
      'Create a Payment',
      name: 'createPayment',
      desc: '',
      args: [],
    );
  }

  /// `View Credit History`
  String get viewCreditHistory {
    return Intl.message(
      'View Credit History',
      name: 'viewCreditHistory',
      desc: '',
      args: [],
    );
  }

  /// `Enter Visa Transaction Number`
  String get enterVisaTransactionNumber {
    return Intl.message(
      'Enter Visa Transaction Number',
      name: 'enterVisaTransactionNumber',
      desc: '',
      args: [],
    );
  }

  /// `Visa`
  String get visa {
    return Intl.message(
      'Visa',
      name: 'visa',
      desc: '',
      args: [],
    );
  }

  /// `Save Payment`
  String get savePayment {
    return Intl.message(
      'Save Payment',
      name: 'savePayment',
      desc: '',
      args: [],
    );
  }

  /// `The remaining balance`
  String get remainingBalance {
    return Intl.message(
      'The remaining balance',
      name: 'remainingBalance',
      desc: '',
      args: [],
    );
  }

  /// `Credit History`
  String get creditHistory {
    return Intl.message(
      'Credit History',
      name: 'creditHistory',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Enter at least one amount for a payment mode`
  String get enterAtLeastOnAmount {
    return Intl.message(
      'Enter at least one amount for a payment mode',
      name: 'enterAtLeastOnAmount',
      desc: '',
      args: [],
    );
  }

  /// `The customer payment created successfully!`
  String get paymentCreatedSuccessfully {
    return Intl.message(
      'The customer payment created successfully!',
      name: 'paymentCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Scan a barcode`
  String get scanBarcode {
    return Intl.message(
      'Scan a barcode',
      name: 'scanBarcode',
      desc: '',
      args: [],
    );
  }

  /// `Please Choose The Mode Of Payment`
  String get choosePaymentMode {
    return Intl.message(
      'Please Choose The Mode Of Payment',
      name: 'choosePaymentMode',
      desc: '',
      args: [],
    );
  }

  /// `Online Payment`
  String get onlinePayment {
    return Intl.message(
      'Online Payment',
      name: 'onlinePayment',
      desc: '',
      args: [],
    );
  }

  /// `Bank Transfer`
  String get bankTransfer {
    return Intl.message(
      'Bank Transfer',
      name: 'bankTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Cash Payment`
  String get cashPayment {
    return Intl.message(
      'Cash Payment',
      name: 'cashPayment',
      desc: '',
      args: [],
    );
  }

  /// `Your payment was Successfully!`
  String get successfullyPayment {
    return Intl.message(
      'Your payment was Successfully!',
      name: 'successfullyPayment',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for your payment and enjoy the app!`
  String get successfullyPaymentDescription {
    return Intl.message(
      'Thanks for your payment and enjoy the app!',
      name: 'successfullyPaymentDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your payment was failed!`
  String get failedPayment {
    return Intl.message(
      'Your payment was failed!',
      name: 'failedPayment',
      desc: '',
      args: [],
    );
  }

  /// `Your payment was failed for a reason and you can try again!`
  String get failedPaymentDescription {
    return Intl.message(
      'Your payment was failed for a reason and you can try again!',
      name: 'failedPaymentDescription',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Loyalty Point History`
  String get loyaltyPointHistory {
    return Intl.message(
      'Loyalty Point History',
      name: 'loyaltyPointHistory',
      desc: '',
      args: [],
    );
  }

  /// `Point`
  String get point {
    return Intl.message(
      'Point',
      name: 'point',
      desc: '',
      args: [],
    );
  }

  /// `Loyalty`
  String get loyalty {
    return Intl.message(
      'Loyalty',
      name: 'loyalty',
      desc: '',
      args: [],
    );
  }

  /// `View Points`
  String get viewPoints {
    return Intl.message(
      'View Points',
      name: 'viewPoints',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points {
    return Intl.message(
      'Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `The greater the number of orders a customer makes, the higher the points they get.`
  String get pointsDescription {
    return Intl.message(
      'The greater the number of orders a customer makes, the higher the points they get.',
      name: 'pointsDescription',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Earned`
  String get earned {
    return Intl.message(
      'Earned',
      name: 'earned',
      desc: '',
      args: [],
    );
  }

  /// `Spent`
  String get spent {
    return Intl.message(
      'Spent',
      name: 'spent',
      desc: '',
      args: [],
    );
  }

  /// `Addresses`
  String get addresses {
    return Intl.message(
      'Addresses',
      name: 'addresses',
      desc: '',
      args: [],
    );
  }

  /// `Recharge Points`
  String get rechargePoint {
    return Intl.message(
      'Recharge Points',
      name: 'rechargePoint',
      desc: '',
      args: [],
    );
  }

  /// `Redeeming Points`
  String get redeemPoint {
    return Intl.message(
      'Redeeming Points',
      name: 'redeemPoint',
      desc: '',
      args: [],
    );
  }

  /// `Point expire duration by days`
  String get pointExpireDuration {
    return Intl.message(
      'Point expire duration by days',
      name: 'pointExpireDuration',
      desc: '',
      args: [],
    );
  }

  /// `Enable pay by point split payment till`
  String get enableSplitPaymentTill {
    return Intl.message(
      'Enable pay by point split payment till',
      name: 'enableSplitPaymentTill',
      desc: '',
      args: [],
    );
  }

  /// `Your Business hours updated successfully!`
  String get businessHoursUpdatedSuccessfully {
    return Intl.message(
      'Your Business hours updated successfully!',
      name: 'businessHoursUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter times in 12-hour format for all enabled days.`
  String get emptyHoursError {
    return Intl.message(
      'Please enter times in 12-hour format for all enabled days.',
      name: 'emptyHoursError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter times in 12-hour format`
  String get timeFormatError {
    return Intl.message(
      'Please enter times in 12-hour format',
      name: 'timeFormatError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter all time types. (AM/PM)`
  String get timeTypeFormat {
    return Intl.message(
      'Please enter all time types. (AM/PM)',
      name: 'timeTypeFormat',
      desc: '',
      args: [],
    );
  }

  /// `Percentage`
  String get percentage {
    return Intl.message(
      'Percentage',
      name: 'percentage',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get value {
    return Intl.message(
      'Value',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Discount value updated successfully!`
  String get discountUpdatedSuccessfully {
    return Intl.message(
      'Discount value updated successfully!',
      name: 'discountUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enter a value for discount`
  String get enterDiscountError {
    return Intl.message(
      'Enter a value for discount',
      name: 'enterDiscountError',
      desc: '',
      args: [],
    );
  }

  /// `This value will apply to all products, are you sure about this?`
  String get applyDiscountWarning {
    return Intl.message(
      'This value will apply to all products, are you sure about this?',
      name: 'applyDiscountWarning',
      desc: '',
      args: [],
    );
  }

  /// `By enabling discount this allow user to have a specific amount of money (AED) as discount. By disabling discount this does not allow user to have a specific amount of money (AED) as to show as a discount. By enabling percentage it allow user to make percentage discount.`
  String get applyDiscountTooltip {
    return Intl.message(
      'By enabling discount this allow user to have a specific amount of money (AED) as discount. By disabling discount this does not allow user to have a specific amount of money (AED) as to show as a discount. By enabling percentage it allow user to make percentage discount.',
      name: 'applyDiscountTooltip',
      desc: '',
      args: [],
    );
  }

  /// `By enabling print it allows user to print receipts. By disabling print it prevents from printing receipts.`
  String get printTooltipText {
    return Intl.message(
      'By enabling print it allows user to print receipts. By disabling print it prevents from printing receipts.',
      name: 'printTooltipText',
      desc: '',
      args: [],
    );
  }

  /// `By enabling reprint it allows to reprint a printed receipt. Footer message appears at the bottom of the receipt.`
  String get rePrintTooltipText {
    return Intl.message(
      'By enabling reprint it allows to reprint a printed receipt. Footer message appears at the bottom of the receipt.',
      name: 'rePrintTooltipText',
      desc: '',
      args: [],
    );
  }

  /// `If the merchants wants to have a copy of the user's receipt.`
  String get merchantCopyTooltip {
    return Intl.message(
      'If the merchants wants to have a copy of the user\'s receipt.',
      name: 'merchantCopyTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Discount Settings`
  String get discountSettings {
    return Intl.message(
      'Discount Settings',
      name: 'discountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Loyalty Settings`
  String get loyaltySettings {
    return Intl.message(
      'Loyalty Settings',
      name: 'loyaltySettings',
      desc: '',
      args: [],
    );
  }

  /// `recharge & redeem point of all items recalculate based on your setting  , are you sure to continue?`
  String get applyLoyaltyWarning {
    return Intl.message(
      'recharge & redeem point of all items recalculate based on your setting  , are you sure to continue?',
      name: 'applyLoyaltyWarning',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Tax value of branch country: `
  String get branchCountryTaxIs {
    return Intl.message(
      'Tax value of branch country: ',
      name: 'branchCountryTaxIs',
      desc: '',
      args: [],
    );
  }

  /// `Optional Parameters Updated Successfully!`
  String get updateOptionalParamsSuccessfully {
    return Intl.message(
      'Optional Parameters Updated Successfully!',
      name: 'updateOptionalParamsSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `POS Parameters Updated Successfully!`
  String get updatePOSParamsSuccessfully {
    return Intl.message(
      'POS Parameters Updated Successfully!',
      name: 'updatePOSParamsSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `POS Device`
  String get posDevices {
    return Intl.message(
      'POS Device',
      name: 'posDevices',
      desc: '',
      args: [],
    );
  }

  /// `Stock Details`
  String get stockDetails {
    return Intl.message(
      'Stock Details',
      name: 'stockDetails',
      desc: '',
      args: [],
    );
  }

  /// `Your configuration changed successfully!`
  String get configurationsSavedSuccessfully {
    return Intl.message(
      'Your configuration changed successfully!',
      name: 'configurationsSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Product added successfully!`
  String get productAddedSuccessfully {
    return Intl.message(
      'Product added successfully!',
      name: 'productAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email.`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email.',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Notification Type`
  String get notificationType {
    return Intl.message(
      'Notification Type',
      name: 'notificationType',
      desc: '',
      args: [],
    );
  }

  /// `This field allows you to select the preferred method(s) of receiving notifications. You can choose to receive notifications via Email, SMS, or both.`
  String get notificationTypeTooltip {
    return Intl.message(
      'This field allows you to select the preferred method(s) of receiving notifications. You can choose to receive notifications via Email, SMS, or both.',
      name: 'notificationTypeTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Notification Trigger`
  String get notificationEvent {
    return Intl.message(
      'Notification Trigger',
      name: 'notificationEvent',
      desc: '',
      args: [],
    );
  }

  /// `This field specifies the event that will trigger the notification. Select the relevant event, such as order confirmation, shipping updates, or promotional offers, for which you wish to receive notifications.`
  String get notificationEventTooltip {
    return Intl.message(
      'This field specifies the event that will trigger the notification. Select the relevant event, such as order confirmation, shipping updates, or promotional offers, for which you wish to receive notifications.',
      name: 'notificationEventTooltip',
      desc: '',
      args: [],
    );
  }

  /// `This field is where you can input the actual message that will be sent as a notification. Ensure the text is clear and includes all necessary information relevant to the event chosen.`
  String get notificationTextTooltip {
    return Intl.message(
      'This field is where you can input the actual message that will be sent as a notification. Ensure the text is clear and includes all necessary information relevant to the event chosen.',
      name: 'notificationTextTooltip',
      desc: '',
      args: [],
    );
  }

  /// `This feature allows SMS notifications to be sent to customers, keeping them informed about their orders and updates.`
  String get smsAllowedTooltip {
    return Intl.message(
      'This feature allows SMS notifications to be sent to customers, keeping them informed about their orders and updates.',
      name: 'smsAllowedTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Select Visible apps`
  String get selectVisibleApps {
    return Intl.message(
      'Select Visible apps',
      name: 'selectVisibleApps',
      desc: '',
      args: [],
    );
  }

  /// `Main Category deleted successfully!`
  String get mainCategoryDeletedSuccessfully {
    return Intl.message(
      'Main Category deleted successfully!',
      name: 'mainCategoryDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category deleted successfully!`
  String get subCategoryDeletedSuccessfully {
    return Intl.message(
      'Sub Category deleted successfully!',
      name: 'subCategoryDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete Customer`
  String get deleteCustomer {
    return Intl.message(
      'Delete Customer',
      name: 'deleteCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Delete Expense`
  String get deleteExpense {
    return Intl.message(
      'Delete Expense',
      name: 'deleteExpense',
      desc: '',
      args: [],
    );
  }

  /// `Max Expiring Point To Notify Customer`
  String get maxExpiringPointToNotifyCustomer {
    return Intl.message(
      'Max Expiring Point To Notify Customer',
      name: 'maxExpiringPointToNotifyCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Remained Days To Expire Point To Notify Customer`
  String get remainedDaysToExpirePointToNotifyCustomer {
    return Intl.message(
      'Remained Days To Expire Point To Notify Customer',
      name: 'remainedDaysToExpirePointToNotifyCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Products & Stock`
  String get productsAndStock {
    return Intl.message(
      'Products & Stock',
      name: 'productsAndStock',
      desc: '',
      args: [],
    );
  }

  /// `System Management`
  String get systemManagement {
    return Intl.message(
      'System Management',
      name: 'systemManagement',
      desc: '',
      args: [],
    );
  }

  /// `Online Ordering`
  String get onlineOrdering {
    return Intl.message(
      'Online Ordering',
      name: 'onlineOrdering',
      desc: '',
      args: [],
    );
  }

  /// `Phone is Required`
  String get phoneIsRequired {
    return Intl.message(
      'Phone is Required',
      name: 'phoneIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Your Payment mode added successfully`
  String get paymentModeAddedSuccessfully {
    return Intl.message(
      'Your Payment mode added successfully',
      name: 'paymentModeAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Twitter`
  String get twitter {
    return Intl.message(
      'Twitter',
      name: 'twitter',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp orders will be sent to`
  String get whatsappNumberForOrders {
    return Intl.message(
      'Whatsapp orders will be sent to',
      name: 'whatsappNumberForOrders',
      desc: '',
      args: [],
    );
  }

  /// `Receiving order via online store`
  String get onlineOrderingTooltip {
    return Intl.message(
      'Receiving order via online store',
      name: 'onlineOrderingTooltip',
      desc: '',
      args: [],
    );
  }

  /// `When online ordering is off or out of working hours, this message will appear on the store page`
  String get closeMessageTooltip {
    return Intl.message(
      'When online ordering is off or out of working hours, this message will appear on the store page',
      name: 'closeMessageTooltip',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get engMessage {
    return Intl.message(
      'English',
      name: 'engMessage',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arMessage {
    return Intl.message(
      'Arabic',
      name: 'arMessage',
      desc: '',
      args: [],
    );
  }

  /// `Turkish`
  String get trMessage {
    return Intl.message(
      'Turkish',
      name: 'trMessage',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get frMessage {
    return Intl.message(
      'French',
      name: 'frMessage',
      desc: '',
      args: [],
    );
  }

  /// `Online Ordering Settings Updated Successfully!`
  String get onlineOrderingSettingsSavedSuccessfully {
    return Intl.message(
      'Online Ordering Settings Updated Successfully!',
      name: 'onlineOrderingSettingsSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Messages Settings Updated Successfully!`
  String get messagesSettingsSavedSuccessfully {
    return Intl.message(
      'Messages Settings Updated Successfully!',
      name: 'messagesSettingsSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Categorized`
  String get categorized {
    return Intl.message(
      'Categorized',
      name: 'categorized',
      desc: '',
      args: [],
    );
  }

  /// `Allow discount to all the products max by`
  String get allowDiscountToAllProducts {
    return Intl.message(
      'Allow discount to all the products max by',
      name: 'allowDiscountToAllProducts',
      desc: '',
      args: [],
    );
  }

  /// `Enter a Valid Phone`
  String get enterValidPhone {
    return Intl.message(
      'Enter a Valid Phone',
      name: 'enterValidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Payment Type`
  String get paymentType {
    return Intl.message(
      'Payment Type',
      name: 'paymentType',
      desc: '',
      args: [],
    );
  }

  /// `Printing Orders From POS`
  String get printingOrdersFromPOS {
    return Intl.message(
      'Printing Orders From POS',
      name: 'printingOrdersFromPOS',
      desc: '',
      args: [],
    );
  }

  /// `Printing Orders From POS Tooltip`
  String get printingOrdersFromPOSTooltip {
    return Intl.message(
      'Printing Orders From POS Tooltip',
      name: 'printingOrdersFromPOSTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Printing Invoice From POS`
  String get printingInvoiceFromPOS {
    return Intl.message(
      'Printing Invoice From POS',
      name: 'printingInvoiceFromPOS',
      desc: '',
      args: [],
    );
  }

  /// `Printing Invoice From POS Tooltip`
  String get printingInvoiceFromPOSTooltip {
    return Intl.message(
      'Printing Invoice From POS Tooltip',
      name: 'printingInvoiceFromPOSTooltip',
      desc: '',
      args: [],
    );
  }

  /// `TRN (Tax Registered Number)`
  String get trn {
    return Intl.message(
      'TRN (Tax Registered Number)',
      name: 'trn',
      desc: '',
      args: [],
    );
  }

  /// `Add Payment Type`
  String get addPaymentType {
    return Intl.message(
      'Add Payment Type',
      name: 'addPaymentType',
      desc: '',
      args: [],
    );
  }

  /// `Payment Reference Number/ID`
  String get paymentReferenceNumber {
    return Intl.message(
      'Payment Reference Number/ID',
      name: 'paymentReferenceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Operator`
  String get operator {
    return Intl.message(
      'Operator',
      name: 'operator',
      desc: '',
      args: [],
    );
  }

  /// `Add Operator`
  String get addOperator {
    return Intl.message(
      'Add Operator',
      name: 'addOperator',
      desc: '',
      args: [],
    );
  }

  /// `Delete Logo Successfully`
  String get deleteLogoSuccessfully {
    return Intl.message(
      'Delete Logo Successfully',
      name: 'deleteLogoSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Business name is required`
  String get businessNameIsRequired {
    return Intl.message(
      'Business name is required',
      name: 'businessNameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Customer Address Requirement`
  String get customerAddressRequirement {
    return Intl.message(
      'Customer Address Requirement',
      name: 'customerAddressRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Toggle to require customer address during checkout`
  String get toggleCustomerAddress {
    return Intl.message(
      'Toggle to require customer address during checkout',
      name: 'toggleCustomerAddress',
      desc: '',
      args: [],
    );
  }

  /// `Any Optional Info you want to link with invoice like notes`
  String get optionalMsg {
    return Intl.message(
      'Any Optional Info you want to link with invoice like notes',
      name: 'optionalMsg',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your Logo For The POS Invoice,this logo will be display at the bottom of your printed invoices`
  String get footerLogoMsg {
    return Intl.message(
      'Upload Your Logo For The POS Invoice,this logo will be display at the bottom of your printed invoices',
      name: 'footerLogoMsg',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your Logo For The POS Invoice,this logo will be display at the top of your printed invoices`
  String get headerLogoMsg {
    return Intl.message(
      'Upload Your Logo For The POS Invoice,this logo will be display at the top of your printed invoices',
      name: 'headerLogoMsg',
      desc: '',
      args: [],
    );
  }

  /// `Header Logo`
  String get headerLogo {
    return Intl.message(
      'Header Logo',
      name: 'headerLogo',
      desc: '',
      args: [],
    );
  }

  /// `Store Details`
  String get storeDetails {
    return Intl.message(
      'Store Details',
      name: 'storeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Social Media Link`
  String get socialMediaLink {
    return Intl.message(
      'Social Media Link',
      name: 'socialMediaLink',
      desc: '',
      args: [],
    );
  }

  /// `Let Us Know About Your Business`
  String get letUsKnowAboutYourBusiness {
    return Intl.message(
      'Let Us Know About Your Business',
      name: 'letUsKnowAboutYourBusiness',
      desc: '',
      args: [],
    );
  }

  /// `Please select the type of business that best describes what you do.`
  String get businessTypeStepDescription {
    return Intl.message(
      'Please select the type of business that best describes what you do.',
      name: 'businessTypeStepDescription',
      desc: '',
      args: [],
    );
  }

  /// `What's Your Business Name?`
  String get whatsYourBusinessName {
    return Intl.message(
      'What\'s Your Business Name?',
      name: 'whatsYourBusinessName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the name of your business so we can personalize your experience.`
  String get businessNameStepDescription {
    return Intl.message(
      'Please enter the name of your business so we can personalize your experience.',
      name: 'businessNameStepDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your Business Name`
  String get yourBusinessName {
    return Intl.message(
      'Your Business Name',
      name: 'yourBusinessName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Business Name`
  String get enterYourBusinessName {
    return Intl.message(
      'Enter Your Business Name',
      name: 'enterYourBusinessName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Store Link`
  String get enterYourStoreLink {
    return Intl.message(
      'Enter Your Store Link',
      name: 'enterYourStoreLink',
      desc: '',
      args: [],
    );
  }

  /// `Provide your store’s online link to connect your business seamlessly.`
  String get domainLinkStepDescription {
    return Intl.message(
      'Provide your store’s online link to connect your business seamlessly.',
      name: 'domainLinkStepDescription',
      desc: '',
      args: [],
    );
  }

  /// `Store Link`
  String get storeLink {
    return Intl.message(
      'Store Link',
      name: 'storeLink',
      desc: '',
      args: [],
    );
  }

  /// `Enter your store's URL here`
  String get enterYouStoreUrl {
    return Intl.message(
      'Enter your store\'s URL here',
      name: 'enterYouStoreUrl',
      desc: '',
      args: [],
    );
  }

  /// `Get Orders Sent to Your WhatsApp`
  String get getOrderWhatsappNumber {
    return Intl.message(
      'Get Orders Sent to Your WhatsApp',
      name: 'getOrderWhatsappNumber',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get whatsappNumberStepDescription {
    return Intl.message(
      '',
      name: 'whatsappNumberStepDescription',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp Number`
  String get whatsappNumber {
    return Intl.message(
      'Whatsapp Number',
      name: 'whatsappNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Your Country and City`
  String get selectCountryAndCity {
    return Intl.message(
      'Please Select Your Country and City',
      name: 'selectCountryAndCity',
      desc: '',
      args: [],
    );
  }

  /// `Select your store’s country and city to get tailored services.`
  String get countryAndCityStepDescription {
    return Intl.message(
      'Select your store’s country and city to get tailored services.',
      name: 'countryAndCityStepDescription',
      desc: '',
      args: [],
    );
  }

  /// `Let us help you to configure your restaurant!`
  String get configureRestaurant {
    return Intl.message(
      'Let us help you to configure your restaurant!',
      name: 'configureRestaurant',
      desc: '',
      args: [],
    );
  }

  /// `Let’s configure your store so your staff can take orders and update them easily.`
  String get configureRestaurantStepDescription {
    return Intl.message(
      'Let’s configure your store so your staff can take orders and update them easily.',
      name: 'configureRestaurantStepDescription',
      desc: '',
      args: [],
    );
  }

  /// `Will your waiters be taking orders using this system? If so, we can create access for them now.`
  String get willWaitersBeTakingOrders {
    return Intl.message(
      'Will your waiters be taking orders using this system? If so, we can create access for them now.',
      name: 'willWaitersBeTakingOrders',
      desc: '',
      args: [],
    );
  }

  /// `Will you be placing a screen in the kitchen? This will allow your kitchen staff to update the status of each order.`
  String get willYouBePlacingScreenInTheKitchen {
    return Intl.message(
      'Will you be placing a screen in the kitchen? This will allow your kitchen staff to update the status of each order.',
      name: 'willYouBePlacingScreenInTheKitchen',
      desc: '',
      args: [],
    );
  }

  /// `Include Demo Data for a Quick Start?`
  String get includeDemoData {
    return Intl.message(
      'Include Demo Data for a Quick Start?',
      name: 'includeDemoData',
      desc: '',
      args: [],
    );
  }

  /// `Start with demo data to explore the system? It’s easy to remove later. Or, handle the setup yourself if you prefer.`
  String get includeDemoDataStepDescription {
    return Intl.message(
      'Start with demo data to explore the system? It’s easy to remove later. Or, handle the setup yourself if you prefer.',
      name: 'includeDemoDataStepDescription',
      desc: '',
      args: [],
    );
  }

  /// `I need demo data`
  String get doYouNeedDemoData {
    return Intl.message(
      'I need demo data',
      name: 'doYouNeedDemoData',
      desc: '',
      args: [],
    );
  }

  /// `No, I can handle it myself!`
  String get noICanHandleIt {
    return Intl.message(
      'No, I can handle it myself!',
      name: 'noICanHandleIt',
      desc: '',
      args: [],
    );
  }

  /// `Explore and Setup`
  String get exploreAndSetup {
    return Intl.message(
      'Explore and Setup',
      name: 'exploreAndSetup',
      desc: '',
      args: [],
    );
  }

  /// `Store Setup Guide : Essential Features and Customization Options`
  String get setupGuideDescription {
    return Intl.message(
      'Store Setup Guide : Essential Features and Customization Options',
      name: 'setupGuideDescription',
      desc: '',
      args: [],
    );
  }

  /// `1. Online Ordering`
  String get OnlineOrdering1Title {
    return Intl.message(
      '1. Online Ordering',
      name: 'OnlineOrdering1Title',
      desc: '',
      args: [],
    );
  }

  /// `Control online orders by managing the WhatsApp receiver and setting your store hours.`
  String get OnlineOrdering1Description {
    return Intl.message(
      'Control online orders by managing the WhatsApp receiver and setting your store hours.',
      name: 'OnlineOrdering1Description',
      desc: '',
      args: [],
    );
  }

  /// `Manage Ordering`
  String get manageOrdering {
    return Intl.message(
      'Manage Ordering',
      name: 'manageOrdering',
      desc: '',
      args: [],
    );
  }

  /// `2. Manage Items`
  String get ManageItems2 {
    return Intl.message(
      '2. Manage Items',
      name: 'ManageItems2',
      desc: '',
      args: [],
    );
  }

  /// `Add, edit, and organize your product listings for seamless sales.`
  String get ManageItems2Description {
    return Intl.message(
      'Add, edit, and organize your product listings for seamless sales.',
      name: 'ManageItems2Description',
      desc: '',
      args: [],
    );
  }

  /// `Item List`
  String get itemList {
    return Intl.message(
      'Item List',
      name: 'itemList',
      desc: '',
      args: [],
    );
  }

  /// `3. Order Management`
  String get OrderManagement3 {
    return Intl.message(
      '3. Order Management',
      name: 'OrderManagement3',
      desc: '',
      args: [],
    );
  }

  /// `Effortlessly track and manage all customer orders from a single, unified dashboard.`
  String get OrderManagement3Description {
    return Intl.message(
      'Effortlessly track and manage all customer orders from a single, unified dashboard.',
      name: 'OrderManagement3Description',
      desc: '',
      args: [],
    );
  }

  /// `Manage Orders`
  String get manageOrders {
    return Intl.message(
      'Manage Orders',
      name: 'manageOrders',
      desc: '',
      args: [],
    );
  }

  /// `4. Customize Your Store`
  String get customizeYourStore4 {
    return Intl.message(
      '4. Customize Your Store',
      name: 'customizeYourStore4',
      desc: '',
      args: [],
    );
  }

  /// `Personalize your stores appearance and settings to match your brand.`
  String get customizeYourStore4Description {
    return Intl.message(
      'Personalize your stores appearance and settings to match your brand.',
      name: 'customizeYourStore4Description',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp Account`
  String get whatsappAccount {
    return Intl.message(
      'WhatsApp Account',
      name: 'whatsappAccount',
      desc: '',
      args: [],
    );
  }

  /// `Set up alerts and notifications to stay updated on order status and important.`
  String get whatsappAccountDescription {
    return Intl.message(
      'Set up alerts and notifications to stay updated on order status and important.',
      name: 'whatsappAccountDescription',
      desc: '',
      args: [],
    );
  }

  /// `Update Account`
  String get updateAccount {
    return Intl.message(
      'Update Account',
      name: 'updateAccount',
      desc: '',
      args: [],
    );
  }

  /// `SMS Notifications`
  String get smsNotification {
    return Intl.message(
      'SMS Notifications',
      name: 'smsNotification',
      desc: '',
      args: [],
    );
  }

  /// `Stay updated with custom alerts for orders, events, and key updates.`
  String get smsNotificationDescription {
    return Intl.message(
      'Stay updated with custom alerts for orders, events, and key updates.',
      name: 'smsNotificationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Setup Notifications`
  String get setupNotification {
    return Intl.message(
      'Setup Notifications',
      name: 'setupNotification',
      desc: '',
      args: [],
    );
  }

  /// `Staff Management`
  String get staffManagement {
    return Intl.message(
      'Staff Management',
      name: 'staffManagement',
      desc: '',
      args: [],
    );
  }

  /// `Assign roles, monitor performance, and manage staff schedules.`
  String get staffManagementDescription {
    return Intl.message(
      'Assign roles, monitor performance, and manage staff schedules.',
      name: 'staffManagementDescription',
      desc: '',
      args: [],
    );
  }

  /// `Manage Staff`
  String get manageStaff {
    return Intl.message(
      'Manage Staff',
      name: 'manageStaff',
      desc: '',
      args: [],
    );
  }

  /// `Manage Expense`
  String get manageExpense {
    return Intl.message(
      'Manage Expense',
      name: 'manageExpense',
      desc: '',
      args: [],
    );
  }

  /// `Keep track of your business expenses for better financial management.`
  String get manageExpenseDescription {
    return Intl.message(
      'Keep track of your business expenses for better financial management.',
      name: 'manageExpenseDescription',
      desc: '',
      args: [],
    );
  }

  /// `Maintain customer profiles and interaction history for personalized service.`
  String get customerManagementDescription {
    return Intl.message(
      'Maintain customer profiles and interaction history for personalized service.',
      name: 'customerManagementDescription',
      desc: '',
      args: [],
    );
  }

  /// `Table Management`
  String get tableManagement {
    return Intl.message(
      'Table Management',
      name: 'tableManagement',
      desc: '',
      args: [],
    );
  }

  /// `Manage Tables`
  String get manageTables {
    return Intl.message(
      'Manage Tables',
      name: 'manageTables',
      desc: '',
      args: [],
    );
  }

  /// `Organize and manage table reservations and dining arrangements.`
  String get tableManagementDescription {
    return Intl.message(
      'Organize and manage table reservations and dining arrangements.',
      name: 'tableManagementDescription',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Adjust app preferences, including payment methods, languages, and more.`
  String get settingsDescription {
    return Intl.message(
      'Adjust app preferences, including payment methods, languages, and more.',
      name: 'settingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Go to Settings`
  String get goToSettings {
    return Intl.message(
      'Go to Settings',
      name: 'goToSettings',
      desc: '',
      args: [],
    );
  }

  /// `Download APKs`
  String get downloadAPKs {
    return Intl.message(
      'Download APKs',
      name: 'downloadAPKs',
      desc: '',
      args: [],
    );
  }

  /// `Download the latest app versions directly for installation on your devices.`
  String get downloadAPKsDescription {
    return Intl.message(
      'Download the latest app versions directly for installation on your devices.',
      name: 'downloadAPKsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Delete Item`
  String get deleteItem {
    return Intl.message(
      'Delete Item',
      name: 'deleteItem',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this item?`
  String get deleteItemDesc {
    return Intl.message(
      'Are you sure you want to delete this item?',
      name: 'deleteItemDesc',
      desc: '',
      args: [],
    );
  }

  /// `Add Area`
  String get addArea {
    return Intl.message(
      'Add Area',
      name: 'addArea',
      desc: '',
      args: [],
    );
  }

  /// `Edit Area`
  String get editArea {
    return Intl.message(
      'Edit Area',
      name: 'editArea',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Order`
  String get minimumOrder {
    return Intl.message(
      'Minimum Order',
      name: 'minimumOrder',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fee`
  String get deliveryFee {
    return Intl.message(
      'Delivery Fee',
      name: 'deliveryFee',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Management`
  String get deliveryManagement {
    return Intl.message(
      'Delivery Management',
      name: 'deliveryManagement',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Discount`
  String get maxDiscount {
    return Intl.message(
      'Maximum Discount',
      name: 'maxDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Area Added Successfully!`
  String get areaAddedSuccessfully {
    return Intl.message(
      'Area Added Successfully!',
      name: 'areaAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Area Edited Successfully!`
  String get areaEditedSuccessfully {
    return Intl.message(
      'Area Edited Successfully!',
      name: 'areaEditedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Area Deleted Successfully!`
  String get areaDeletedSuccessfully {
    return Intl.message(
      'Area Deleted Successfully!',
      name: 'areaDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this area?`
  String get areYouSureDeleteArea {
    return Intl.message(
      'Are you sure you want to delete this area?',
      name: 'areYouSureDeleteArea',
      desc: '',
      args: [],
    );
  }

  /// `Delete Area`
  String get deleteArea {
    return Intl.message(
      'Delete Area',
      name: 'deleteArea',
      desc: '',
      args: [],
    );
  }

  /// `Scan or Download Catalogak link for this Table`
  String get downloadOrScanQrCode {
    return Intl.message(
      'Scan or Download Catalogak link for this Table',
      name: 'downloadOrScanQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closed {
    return Intl.message(
      'Closed',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `Manage if refund allowed or not`
  String get refund {
    return Intl.message(
      'Manage if refund allowed or not',
      name: 'refund',
      desc: '',
      args: [],
    );
  }

  /// `Apply Discount`
  String get applyDiscount {
    return Intl.message(
      'Apply Discount',
      name: 'applyDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Store Status ({lang})`
  String storeStatus(String lang) {
    return Intl.message(
      'Store Status ($lang)',
      name: 'storeStatus',
      desc: '',
      args: [lang],
    );
  }

  /// `Attention`
  String get attention {
    return Intl.message(
      'Attention',
      name: 'attention',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to leave the page without saving your new updates?`
  String get areYouSureWantToLeaveWhitOutSaveData {
    return Intl.message(
      'Do you want to leave the page without saving your new updates?',
      name: 'areYouSureWantToLeaveWhitOutSaveData',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get serviceType {
    return Intl.message(
      'Service Type',
      name: 'serviceType',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Discount`
  String get deliveryDiscount {
    return Intl.message(
      'Delivery Discount',
      name: 'deliveryDiscount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
