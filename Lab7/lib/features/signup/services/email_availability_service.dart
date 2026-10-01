abstract interface class EmailAvailabilityService {
  Future<bool> isEmailAvailable(String email);
}

class FakeEmailAvailabilityService implements EmailAvailabilityService {
  const FakeEmailAvailabilityService({this.delay = const Duration(seconds: 2)});

  final Duration delay;

  @override
  Future<bool> isEmailAvailable(String email) async {
    await Future<void>.delayed(delay);
    return !email.trim().toLowerCase().startsWith('taken');
  }
}
