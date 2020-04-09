/// App Config File.
class Config {
  static const bool APP_DEBUG = true;
  static const String APP_URL_PROD = 'http://81.141.186.138:8888/';
  static const String APP_URL_DEBUG = 'http://192.168.42.212:8000/';

  static const APP_URL = APP_DEBUG ? APP_URL_DEBUG : APP_URL_PROD;
}
