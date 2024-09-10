class Validators {

  static String? validateYearsOfExperience(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your years of experience';
    }

    final numericValue = int.tryParse(value);

    if (numericValue == null) {
      return 'Please enter a valid number';
    }
    if (numericValue < 0 || numericValue > 20) {
      return 'Please enter a value between 0 and 20';
    }

    return null;
  }


  static String? validatePhoneNumber(String? value) {
    String pattern = r'^\d{10}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }


  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter the email';
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }


  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    if (value.length > 50) {
      return 'Name must not exceed 50 characters';
    }
    return null;
  }
static String? validateZipcode(String? value) {
  String pattern = r'^\d{6}$'; 
  RegExp regExp = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return 'Please enter the ZIP code';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter a valid 6-digit ZIP code';
  }
  return null;
}

   static String? validateAddressLine(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the address line';
    }
    if (value.length < 6) {
      return 'Address must be at least 6 characters long';
    }
    return null;
  }


  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the city';
    }
    if (value.length < 2) {
      return 'City name must be at least 2 characters long';
    }
    return null;
  }

  // Validate state
  static String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the state';
    }
    if (value.length < 2) {
      return 'State name must be at least 2 characters long';
    }
    return null;
  }

  
}
