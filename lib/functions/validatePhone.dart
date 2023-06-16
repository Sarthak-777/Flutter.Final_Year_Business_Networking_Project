bool validatePhoneNumber(String phoneNumber) {
  RegExp phoneRegex = RegExp(r'^\d{10}$');
  return phoneRegex.hasMatch(phoneNumber);
}
