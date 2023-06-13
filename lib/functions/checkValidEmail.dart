bool validEmail(email) {
  String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  RegExp emailRegex = RegExp(pattern);
  return emailRegex.hasMatch(email);
}
