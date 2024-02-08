class ValidationUtils{
  static bool isEmailValidate (String? email){
    if (email ==null) return false;
    var regex =RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(email);
  }
  static bool isPasswordValidate(String? password){
    if(password ==null) return false;
    var regex = RegExp(r"^((?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,20})$");
    return regex.hasMatch(password);
  }
  static bool isNameValidate(String? name){
    if(name ==null) return false;
    var regex =RegExp('[a-zA-Z]');
    return regex.hasMatch(name);
  }

}