bool isExpired(DateTime expiryDate) {
  print(expiryDate);

  DateTime currentDateTime = DateTime.now();
  print(currentDateTime);
  return currentDateTime.isAfter(expiryDate) ||
      currentDateTime.isAtSameMomentAs(expiryDate);
}
