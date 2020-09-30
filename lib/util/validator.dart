class Validator {

  //Email:
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  // Password:
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static final RegExp _DirectionRegExp = RegExp(
  r'^A-Za-z,.$'
  );

  static final RegExp _LocationRegExp = RegExp(
      r'A-Za-z,.$'
  );
  static final RegExp _PhoneRegExp = RegExp(
      r'[0-9]$'
  );

  static isValidEmail(String email){
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password){
    return true; //_passwordRegExp.hasMatch(password);
  }
  static isValidLocation(String location){
    //return _LocationRegExp.hasMatch(location);
    return true;
  }
  static isValidDirection(String direction){
    //return _DirectionRegExp.hasMatch(direction);
    return true;
  }
  static isValidPhone(String phone){
    return _PhoneRegExp.hasMatch(phone);
  }
}