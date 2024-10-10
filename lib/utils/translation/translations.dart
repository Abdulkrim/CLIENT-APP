// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:injectable/injectable.dart';
//
// class Translation extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys => {
//         "en_US": {
//           "goodMorning": "Good Morning",
//           "goodAfternoon": "Good Afternoon",
//           "goodEvening": "Good Evening",
//           "cartPreview": "Cart Preview",
//           "total": "Total",
//           "checkout": "Checkout",
//           "city": "City",
//           "street": "Street",
//           "flat": "Flat",
//           "completeAddress": "Complete Address",
//           "additionalInformation": "Additional Information",
//           "setAsDefault": "Set as default",
//           "phoneNumber": "Phone Number",
//           "location": "Location",
//           "district": "District",
//           "buildingName": "Building Name",
//           "optionalName": "Name (Optional)",
//           "register": "Register",
//           "registration": "Registration",
//           "fullName": "Full Name",
//           "enterNumber": "Please enter your mobile number",
//           "enterCity": "Please select your city",
//           "search": "Search",
//           "Add": "add",
//           "newAddress": "New Address",
//           "changeAddress": "Change Address",
//           "clear": "Clear",
//           "customerInfo": "Customer Info",
//           "products": "Products",
//           "notes": "Notes",
//           "orderAgain": "Order Again",
//           "weAcceptOnly": "we accept only ",
//           "cash": "Cash",
//           "visa": "Card",
//           "card": "Card",
//           "offer": "Offer",
//           "discount": "Discount",
//           "normal": "Normal",
//           "newProduct": "New",
//           "arrived": "New Arrival",
//           "delivery": "Delivery",
//           "pickup": "Pickup",
//           "pleaseChoosePaymentMode": "Please choose payment mode",
//           "customer": "Customer",
//           "EN": "ENG",
//           "subCategoryAddedSuccessfully": "Subcategory added successfully",
//           "filter":"Filter"
//         },
//         "tr_TR": {
//           "goodMorning": "Günaydın",
//           "goodAfternoon": "Tünaydın",
//           "goodEvening": "iyi akşamlar",
//           "cartPreview": "Sepet Önizlemesi",
//           "total": "Toplam",
//           "checkout": "Çıkış yapmak",
//           "city": "şehir",
//           "street": "sokak",
//           "flat": "düz",
//           "completeAddress": "tam adresi",
//           "additionalInformation": "Ek Bilgiler",
//           "setAsDefault": "Varsayılan olarak ayarla",
//           "phoneNumber": "telefon numarası",
//           "location": "konum",
//           "district": "semt",
//           "buildingName": "Bina Adı",
//           "optionalName": "İsim: (İsteğe bağlı)",
//           "register": "kayıt olmak",
//           "registration": "kayıt",
//           "fullName": "Ad Soyad",
//           "enterNumber": "Lütfen telefon numaranızı giriniz",
//           "enterCity": "Lütfen şehrinizi seçin",
//           "search": "aramak",
//           "Add": "eklemek",
//           "newAddress": "Yeni adres",
//           "changeAddress": "Adres değiştir",
//           "addresses": "adresler",
//           "clear": "temizlemek",
//           "customerInfo": "Müşteri Bilgisi",
//           "products": "ürünler",
//           "notes": "Notlar",
//           "orderAgain": "Tekrar sipariş ver",
//           "weAcceptOnly": "sadece kabul ediyoruz ",
//           "cash": "Peşin",
//           "visa": "kart",
//           "card": "kart",
//           "offer": "teklif",
//           "discount": "İndirim",
//           "normal": "Normal",
//           "newProduct": "Yeni",
//           "arrived": "Yeni gelen",
//           "delivery": "Teslimat",
//           "pickup": "Toplamak",
//           "pleaseChoosePaymentMode": "lütfen ödeme modunu seçin",
//           "customer": "müşteri",
//           "TR": "TÜR",
//           "subCategoryAddedSuccessfully": "Alt Kategori Başarıyla Eklendi",
//           "filter":"Filtre"
//         },
//         "ar_UAE": {
//           "goodMorning": "صباح الخير",
//           "goodAfternoon": "مساء الخير",
//           "goodEvening": "مساء الخير",
//           "cartPreview": "سلة المشتريات",
//           "total": "المجموع",
//           "checkout": "الدفع",
//           "city": "مدينة",
//           "street": "شارع",
//           "flat": "مستوي",
//           "completeAddress": "العنوان الكامل",
//           "additionalInformation": "معلومات إضافية",
//           "setAsDefault": "تعيين كافتراضي",
//           "phoneNumber": "رقم التليفون",
//           "location": "موقع",
//           "district": "يصرف",
//           "buildingName": "اسم المبنى",
//           "optionalName": "الاسم: (اختياري)",
//           "register": "يسجل",
//           "registration": "تسجيل",
//           "fullName": "الاسم الكامل",
//           "enterNumber": "الرجاء إدخال رقم هاتفك المحمول",
//           "enterCity": "الرجاء تحديد مدينتك",
//           "search": "بحث",
//           "Add": "أضف",
//           "newAddress": "عنوان جديد",
//           "changeAddress": "تغيير العنوان",
//           "addresses": "العنواين",
//           "clear": "مسح",
//           "customerInfo": "معلومات الزبون",
//           "products": "المنتجات",
//           "notes": "ملاحظات",
//           "orderAgain": "الطلبات السابقة",
//           "weAcceptOnly": "نحن نقبل المدفوعات فقط ب",
//           "cash": "كاش",
//           "visa": "بطاقة",
//           "card": "بطاقة",
//           "offer": "عرض",
//           "discount": "خصم",
//           "normal": "",
//           "newProduct": "جديد",
//           "arrived": "جديد",
//           "pickup": "استلام",
//           "delivery": "توصيل",
//           "pleaseChoosePaymentMode": "من فضلك اختر طريقة الدفع",
//           "customer": "يا عميل",
//           "AR": "عربي",
//           "subCategoryAddedSuccessfully": "تمت إضافة صنف فرعي بنجاح",
//           "filter":"تصفية"
//         },
//         "fr_FR": {
//           "goodMorning": "Bonjour",
//           "goodAfternoon": "Bon après-midi",
//           "goodEvening": "bonne soirée",
//           "cartPreview": "Aperçu du panier",
//           "total": "Total",
//           "checkout": "Vérifier",
//           "city": "Ville",
//           "street": "Rue",
//           "flat": "Plat",
//           "completeAddress": "Adresse complète",
//           "additionalInformation": "Informations Complémentaires",
//           "setAsDefault": "Définir par défaut",
//           "phoneNumber": "numéro de téléphone",
//           "location": "emplacement",
//           "district": "district",
//           "buildingName": "Nom du bâtiment",
//           "optionalName": "Nom: (optionnel)",
//           "register": "enregistrer",
//           "registration": "inscription",
//           "fullName": "nom et prénom",
//           "enterNumber": "Entrez s'il vous plaît votre numéro de téléphone",
//           "enterCity": "Veuillez sélectionner votre ville",
//           "search": "recherche",
//           "Add": "ajouter",
//           "newAddress": "Nouvelle adresse",
//           "changeAddress": "Changement d'adresse",
//           "addresses": "adresses",
//           "clear": "Clear",
//           "customerInfo": "informations le client",
//           "products": "Des Produits",
//           "notes": "Remarques",
//           "orderAgain": "commander à nouveau",
//           "weAcceptOnly": "nous acceptons seulement ",
//           "cash": "Espèces",
//           "visa": "carte",
//           "card": "carte",
//           "offer": "offre",
//           "discount": "Rabais",
//           "normal": "Normale",
//           "newProduct": "Nouveau",
//           "arrived": "Nouvelle arrivee",
//           "delivery": "Livraison",
//           "pickup": "Ramasser",
//           "pleaseChoosePaymentMode": "veuillez choisir le mode de paiement",
//           "customer": "cliente",
//           "FR": "FRA",
//           "subCategoryAddedSuccessfully": "Sous-catégorie ajoutée avec succès",
//           "filter":"Filtre"
//         }
//       };
// }
//
// enum Languages {
//   arabic,
//   turkish,
//   english,
//   french,
//   ;
//
//   static Languages getEnum(String languageCode) {
//     switch (languageCode) {
//       case 'ar':
//         return Languages.arabic;
//       case 'en':
//         return Languages.english;
//       case 'tr':
//         return Languages.turkish;
//       case 'fr':
//         return Languages.french;
//       default:
//         return Languages.english;
//     }
//   }
// }
//
// sealed class TranslationLocale {
//   final Locale locale;
//   final Languages languages;
//
//   TranslationLocale(this.locale, this.languages);
// }
//
// @lazySingleton
// class EnglishLocale extends TranslationLocale {
//   EnglishLocale(
//       [super.locale = const Locale('en', 'US'),
//       super.languages = Languages.english]);
// }
//
// @lazySingleton
// class FrenchLocale extends TranslationLocale {
//   FrenchLocale(
//       [super.locale = const Locale('fr', 'FR'),
//       super.languages = Languages.french]);
// }
//
// @lazySingleton
// class TurkishLocale extends TranslationLocale {
//   TurkishLocale(
//       [super.locale = const Locale('tr', 'TR'),
//       super.languages = Languages.turkish]);
// }
//
// @lazySingleton
// class ArabicLocale extends TranslationLocale {
//   ArabicLocale(
//       [super.locale = const Locale('ar', 'UAE'),
//       super.languages = Languages.arabic]);
// }
