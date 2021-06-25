enum Environment { STAGING, PROD }

class BaseApis {
  static String PHOTO = '';
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.STAGING:
        setStagingUrl();
        break;
      case Environment.PROD:
        setProductionUrl();
        break;
    }
  }

  static void setStagingUrl() {
    PHOTO="picsum.photos";
  }

  static void setProductionUrl() {
    PHOTO="picsum.photos";
  }
}
