class Images {
  static const String intro1 = "assets/images/onBoarding1.jpg";
  static const String intro2 = "assets/images/onBoarding2.jpg";
  static const String intro3 = "assets/images/onBoarding3.jpg";
  static const String profile = "assets/images/user.png";
  static const String intro4 = "assets/images/intro_4.jpg";
  static const String logo = "assets/images/logo1.png";
  static const String slide = "assets/images/slide.png";
  static const String whatsapp = "assets/images/whatsapp.png";
  static const String telegram = "assets/images/telegram.png";
  static const String viber = "assets/images/viber.png";
  static const String facebook = "assets/images/facebook.png";
  static const String flickr = "assets/images/flickr.png";
  static const String google = "assets/images/google.png";
  static const String linkedin = "assets/images/linkedin.png";
  static const String pinterest = "assets/images/pinterest.png";
  static const String youtube = "assets/images/youtube.png";
  static const String twitter = "assets/images/twitter.png";
  static const String tumblr = "assets/images/tumblr.png";
  static const String instagram = "assets/images/instagram.png";

  //
  static const String socities = "assets/images/socities.jpg";
  static const String hospital1 = "assets/images/hospital1.jpg";
  static const String hospital2 = "assets/images/hospital2.jpg";
  static const String company1 = "assets/images/company1.jpg";
  static const String company2 = "assets/images/company2.jpg";
  static const String event = "assets/images/event.jpg";

  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
