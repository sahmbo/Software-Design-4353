import '../model/clientManageRepo.dart';

class ProfileController {
  //Profile? client; // Holds the client data
  final Profile _profile = Profile(
    fullname: 'Full Name',
    address_1: 'Address 1',
    address_2: 'Address 2',
    city: 'City',
    state: 'State',
    zipcode: 'Zipcode',
  );

  //save the client data
  void saveFullName(String newData) {
    _profile.fullname = newData;
  }
  void saveAddress_1(String newData){
    _profile.address_1 = newData;
  }
  void saveAddress_2(String newData){
    _profile.address_2 = newData;
  }
  void saveCity(String newData){
    _profile.city = newData;
  }
  void saveState(String newData){
    _profile.state = newData;
  }
  void saveZipcode(String newData){
    _profile.zipcode = newData;
  }

  Profile get clientManage => _profile;

}