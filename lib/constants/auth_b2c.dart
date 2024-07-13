// const String redirectURL='https://ageu.page.link?afl=https%3A%2F%2Fbackoffice.ageu.app.br%2Fcallback&apn=br.com.ageu.app&link=https%3A%2F%2Fbackoffice.ageu.app.br%2Fcallback';


String redirectURL =
    'msauth://br.com.doss.vigia/bst92rGI5BRnyNBftkf3pWtGePg%3D';

String clientID = '7472f0f8-c560-4b37-b8cc-fb56b14521a5';
String androidDiscoveryURL =
    'https://dossauth.b2clogin.com/dossauth.onmicrosoft.com/B2C_1_doss_sign_up_sign_in/v2.0/.well-known/openid-configuration';
String iosDiscoveryURL='https://dossauth.b2clogin.com/dossauth.onmicrosoft.com/B2C_1_doss_sign_up_sign_in/v2.0/.well-known/openid-configuration';
List<String> scopes = [
  'openid',
  'offline_access',
  "https://dossauth.onmicrosoft.com/doss-api/tasks.read",
  "https://dossauth.onmicrosoft.com/doss-api/tasks.write",
];