
class AppConfig {
  AppConfig._();

  static const  appState = 'live'; 
  // static const  appState = 'dev'; 

  // Domain
  static const webUrl = (appState=='live')
                      ?'https://wcc.iworldtc.com'
                      :'http://192.168.100.4';
  static const baseUrl = '$webUrl/api/wcc'; 
  
  static const privacyPolicyUrl = ''; 
  static const termsConditionsUrl = ''; 
  
}