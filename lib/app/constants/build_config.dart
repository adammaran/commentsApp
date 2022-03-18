enum Environment { prod, dev, staging }

class BuildConfig {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment environment) {
    switch (environment) {
      case Environment.prod:
        _config = _prodConfig;
        break;
      case Environment.dev:
        _config = _devConfig;
        break;
      case Environment.staging:
        _config = _stagingConfig;
        break;
    }
  }

  static String get baseUrl => _config['baseUrl'];

  static String get appState => _config['appState'];

  static String get homeTitle => _config['homeTitle'];

  static String get environment => _config['environment'];

  static final Map<String, dynamic> _devConfig = {
    'environment': 'dev',
    'baseUrl': 'https://jsonplaceholder.typicode.com/',
    'appState': 'Development',
    'homeTitle': 'Q Agency Development'
  };

  static final Map<String, dynamic> _prodConfig = {
    'environment': 'prod',
    'baseUrl': 'https://jsonplaceholder.typicode.com/',
    'appState': 'Production',
    'homeTitle': 'Q Agency Production'
  };

  static final Map<String, dynamic> _stagingConfig = {
    'environment': 'staging',
    'baseUrl': 'https://jsonplaceholder.typicode.com/',
    'appState': 'Staging',
    'homeTitle': 'Q Agency Staging'
  };
}
