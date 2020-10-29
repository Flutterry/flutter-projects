class Assets {
  static var _imagePath = 'assets/images/';
  static String applicationLogo = '${_imagePath}logo.png';
  static String helloMessage = '${_imagePath}photo 1.png';
  static String signIn = '${_imagePath}photo 2.png';
  static String home = '${_imagePath}photo 3.png';
  static String visa = '${_imagePath}photo 5.png';
  static String done = '${_imagePath}photo 4.png';
  static String videoCall = '${_imagePath}photo 6.jpg';

  static doctor(int i) => '${_imagePath}doctor $i.jpg';

  static user(int i) => '${_imagePath}user $i.jpg';
}
