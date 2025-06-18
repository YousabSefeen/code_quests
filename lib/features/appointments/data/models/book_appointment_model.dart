class BookAppointmentModel {
  final String doctorId;

  final String patientName;
  final String patientGender;
  final String patientAge;
  final String patientProblem;

  final String appointmentDate;
  final String appointmentTime;

  BookAppointmentModel({
    required this.doctorId,
    required this.patientName,
    required this.patientGender,
    required this.patientAge,
    required this.patientProblem,
    required this.appointmentDate,
    required this.appointmentTime,
  });
}
