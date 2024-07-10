function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }

  if (env == 'dev') {
    config.userEmail = 'testkarate1@test.cl'
    config.userPassword = 'clave123456'
  }
   if (env == 'qa') {
    config.userEmail = 'testkarate2@test.cl'
    config.userPassword = 'clave7890'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}