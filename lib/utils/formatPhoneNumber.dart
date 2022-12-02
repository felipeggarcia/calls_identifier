String formatPhoneNumber(phoneNumber) {
  switch (phoneNumber.length) {
    case 10:
      return phoneNumber;
    case 11:
      return phoneNumber[0] == "0" ? phoneNumber.substring(1) : phoneNumber;
    case 15:
      return phoneNumber.substring(5);
    case 18:
      return phoneNumber.substring(6);
    default:
      return phoneNumber;
  }
}
