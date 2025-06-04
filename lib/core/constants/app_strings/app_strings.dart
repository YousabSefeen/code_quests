class AppStrings {

  static List<String> images = [
    //boy
    'https://as1.ftcdn.net/v2/jpg/02/95/51/80/1000_F_295518052_aO5d9CqRhPnjlNDTRDjKLZHNftqfsxzI.jpg',
    //girl
    'https://i.pinimg.com/736x/62/44/97/624497ea5ae28be78867dafce4834e1c.jpg',
    //boy
    'https://i.pinimg.com/736x/6c/6e/d7/6c6ed7f4011b7f926b3f1505475aba16.jpg',

    //girl
    'https://i.pinimg.com/736x/20/f0/3d/20f03d2dc59c8f04ddcb6d6b602a0ebb.jpg',
    //boy
    'https://i.pinimg.com/736x/f2/f1/fa/f2f1fa3a611dfb4f4be81396ebca56eb.jpg',
    //girl
    'https://i.pinimg.com/736x/96/6a/ac/966aacaf096747852a12f9e33f926b96.jpg',
  ];

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
  static const String noAppointmentsAvailableToday = 'There are no appointments available today. Please choose another day.';

  static const String noBookingsMessage = 'You have no bookings at the moment. Start by making a new appointment or check back later.';

  static const String oops='Oops! something is wrong!';
  static const String tryAgain='TRY AGAIN';
  //Error
  static const String errorDisplayTitle = 'An error occurred while displaying';
  static const String errorMessageLabel = 'Error Message: ';
  static const String pastDateBookingError =
      'Appointments cannot be scheduled for past dates. '
      'Please select today\'s date or a future date.';
  static String noInternetConnection='No Internet Connection';
  static const String kNoInternetBookingErrorMessage =
      'Booking an appointment requires an active internet connection to confirm and secure your reservation.\nPlease check your connection and try again.';
static const String bookAppointment='Book Appointment';
static const String cancel='Cancel';
static const String reschedule='Reschedule';
static const String editBookingAppointment='Edit Booking Appointment';
  static const String rescheduleSuccessMessage = 'Appointment rescheduled successfully!';
  static const String yourAppointment = 'Your appointment\nhas been updated!!';
  static const String done = 'Done';
static const String confirmReschedule='Confirm Reschedule';
}
