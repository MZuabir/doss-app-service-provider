class ApiUrls {
  static String endpoint = 'https://doss-api.azurewebsites.net/api/v1/';
//SERVICE PROVIDER
  static String statusURL = 'service-provider/status/';
//VERIFICATION
  static String verificationAllURL = 'verification-request/all?';
  static String serviceProvider = 'service-provider';

  static String verificationCheckURL = 'verification-request/check';
  static String verificationchatURL = 'verification-request/chat';
  static String verificationChatMsgURL =
      'verification-request/chat/messages?ResidentialVerificationRequestId=';
  static String vehiclesAll='vehicle/service-provider/all';
  static String updateVehicle='vehicle/service-provider';
  static String getVehicleTypes='vehicle/type-vehicles';
  static String residentialContacts='contact/residential';
  static String usefullContacts='contact/useful';
  static String activeCustomers='service-provider/active';
  static String profitCustomers='service-provider/profit';
  static String customers='service-provider/customers';
  
  
}
