// import 'package:corona_app/Data/AppConfig.dart';
import 'package:corona_app/config/AppConfig.dart';
import 'package:corona_app/config/RedirectText.dart';
import 'package:corona_app/config/RedirectURL.dart';
import 'package:corona_app/config/ReliefText.dart';
import 'package:corona_app/config/ReliefURL.dart';
import 'package:corona_app/models/app_data.dart';
import 'package:corona_app/scopped_models/fund_scoped_model.dart';
import 'package:corona_app/scopped_models/home_scoped_model.dart';
import 'package:corona_app/scopped_models/reminder_scoped_model.dart';
import 'package:corona_app/scopped_models/sign_in_scoped_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => AppConfig());
  locator.registerLazySingleton(() => ReliefText());
  locator.registerLazySingleton(() => ReliefURL());
  locator.registerLazySingleton(() => RedirectText());
  locator.registerLazySingleton(() => RedirectURL());
  locator.registerLazySingleton(() => AppData());
  locator.registerLazySingleton(() => HomeScopedModel());
  locator.registerLazySingleton(() => ReminderScopedModel());
  locator.registerLazySingleton(() => FundScopedModel());
  locator.registerLazySingleton(() => SignInScopedModel());
}
