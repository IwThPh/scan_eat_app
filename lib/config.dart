/// App Config File.
class Config {
  static const bool APP_DEBUG = true;
  static const String APP_URL_PROD = 'https://www.foodlabel.test/';
  static const String APP_URL_DEBUG = 'http://192.168.42.29:8000/';

  static const APP_URL = APP_DEBUG ? APP_URL_DEBUG : APP_URL_PROD;
}
