import 'package:get_it/get_it.dart';
import 'package:hanplus_flutter/manager/user_manager.dart';
import 'package:logging/logging.dart';
import 'package:hanplus_flutter/services/hp_api_provider.dart';

GetIt locator = GetIt();

setupLog() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

setupLocator() async {
  locator.registerSingleton(UserManager());
  locator.registerLazySingleton(() => UserManager(
      api: locator<HPAPIProvider>()));
  
}

// setupProviders() {
//   providers = [
//     ChangeNotifierProvider.value(
//       value: locator.get<UserManager>(),
//     ),
//     StreamProvider(builder: (context) => locator.get<MarketManager>().prices),
//     StreamProvider(
//         builder: (context) => locator.get<MarketManager>().lastTicker.stream),
//     StreamProvider(
//       builder: (context) => locator.get<RefManager>().data,
//     ),
//     StreamProvider(
//       builder: (context) => locator.get<TimerManager>().tick,
//     )
//   ];
// }
