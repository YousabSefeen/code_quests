class AppStrings {



  // Titles
  static const String login = 'Login';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String register = 'Register';
  static const String registerNow ='$register now';
  static const String emailAlreadyInUseError ='This email address is already in use. If it’s your account, try logging in.';
  static const String unknownError ='Unknown error occurred.';
  static const String doctorProfileTitle = 'Doctor Profile';

  // Labels
  static const String nameLabel = 'Name';
  static const String specializationLabel = 'Specialization';
  static const String bioLabel = 'Bio';
  static const String locationLabel = 'Location';
  static const String weeklySchedule = 'Weekly Schedule:';
  static const String workingDays = 'Working Days';
  static const String defaultHint = 'Tap to select';
  static const String workingDaysHint = ' $defaultHint days';
  static const String workHoursHint = ' $defaultHint hours';
  static const String workingDaysDialogTitle = 'Select your working days';
  static const String workingDaysValidationMessage =
      'Please select at least one working day.';
  static const List<String> weekDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

static const String  confirm='Confirm';
static const String  workHours='Work Hours';
static const String  from='FROM';
static const String  to='TO';


  static const String availableFrom = 'Available From';

  static const String availableTo = 'Available To';
  static const String hintSelectTime = 'Select time';
  static const String requiredField = 'required field';
  static const String feesLabel = 'Fees';

  // Hint texts
  static const String nameHint = 'Enter your full name';
  static const String specializationHint = 'Enter your medical specialization';
  static const String bioHint =
      'Write a short bio about your experience and expertise';
  static const String locationHint = 'Enter your clinic or hospital location';
  static const String feesHint = 'Enter your consultation fees';

  // Validation messages
  static const String nameValidationMessage = 'Please enter your name';
  static const String specializationValidationMessage =
      'Please enter your medical specialization';
  static const String bioValidationMessage =
      'Please enter a short bio about yourself';
  static const String locationValidationMessage =
      'Please enter your clinic or workplace location';
  static const String feeValidationMessage =
      'Please enter your consultation fee';
  static const String feeInvalidMessage = 'Fee must be a valid integer number';

  // Button text
  static const String saveButtonText = 'Save';

  static const String dR = 'Dr. ';
  static const String successMessage = 'Book Appointment Successfully';

  static const List<String> doctorNotAvailableMessage = [
    'Doctor is not available on the selected day. Please check the ',
    '"Working Days"',
    ' section\n to view the doctor\'s availability.',
  ];

  static const String imageNotFound =
      'Incorrect image URLs or changes in the image file\'s location';

  static const String bookingsIsEmpty =
      'There are no bookings currently. Please check back later or add a new booking.';

  static const String oops='Oops! something is wrong!';
  static const String tryAgain='TRY AGAIN';
}
