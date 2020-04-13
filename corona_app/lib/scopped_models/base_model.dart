import 'package:corona_app/config/AppConfig.dart';
import 'package:corona_app/enums/app_enums.dart';
import 'package:corona_app/locator.dart';
import 'package:corona_app/models/app_data.dart';
import 'package:scoped_model/scoped_model.dart';

///Base scoped model for the project whcih other scoped model use to derive from
class BaseModel extends Model {
  ViewState _state;
  ViewState get getState => _state;
  final AppConfig appConfig = locator<AppConfig>();
  final AppData _appData = locator<AppData>();

  void setState(ViewState value) {
    _state = value;
    notifyListeners();
  }

  void setUsername(String value) {
    _appData.username = value;
    notifyListeners();
  }

  String getUsername() => _appData.username;

  // void setRole(Role role) {
  //   _appData.role = role;
  //   notifyListeners();
  // }

  // Role getRole() => _appData.role;

  // addItem(ProductModel value) {
  //   int loc = _appData.items.indexWhere((val) => val.id == value.id);
  //   if (loc != -1) {
  //     _appData.items[loc].quantity += 1;
  //   } else {
  //     value.quantity = 1;
  //     _appData.items.add(value);
  //   }
  //   notifyListeners();
  // }

  // removeItem(ProductModel value) {
  //   int loc = _appData.items.indexWhere((val) => val.id == value.id);
  //   _appData.items[loc].quantity -= 1;
  //   if (_appData.items[loc].quantity == 0) {
  //     _appData.items.removeAt(loc);
  //   }
  //   notifyListeners();
  // }

  // getItems() => _appData.items;

  // AddressModel getSavedAddress() {
  //   return _appData.savedAddress;
  // }

  // clearItems() {
  //   _appData.items = [];
  //   notifyListeners();
  // }
}
