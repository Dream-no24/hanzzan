// 뷰모델 파일: signup_viewmodel.dart
// 뷰와 리포지토리 사이에서 데이터를 관리하고 로직을 처리하는 클래스
import 'signup_model.dart';
import 'signup_repository.dart';

class SignUpViewModel {
  final SignUpRepository _repository = SignUpRepository();

  // 사용자 입력 데이터를 관리하는 모델 인스턴스
  final SignUpModel _signUpModel = SignUpModel(email: '', password: '', verificationCode: '');
  bool isCodeVerified = false;  // 인증 성공 여부를 나타냅니다.

  // 이메일 Getter 및 Setter
  String get email => _signUpModel.email;
  set email(String value) => _signUpModel.email = value;

  // 인증 코드 Getter 및 Setter
  String get verificationCode => _signUpModel.verificationCode;
  set verificationCode(String value) => _signUpModel.verificationCode = value;

  // 비밀번호 Getter 및 Setter
  String get password => _signUpModel.password;
  set password(String value) => _signUpModel.password = value;

  // 사용자가 입력한 이메일로 인증 코드를 발송하는 메서드
  Future<void> sendVerificationCode() async {
    try {
      await _repository.sendVerificationCode(_signUpModel.email);
    } catch (e) {
      throw Exception('인증번호 발송 실패: ${e.toString()}');
    }
  }

  // 사용자가 입력한 인증 코드를 확인하는 메서드
  Future<void> verifyCode() async {
    try {
      isCodeVerified = await _repository.verifyCode(_signUpModel.email, _signUpModel.verificationCode);
    } catch (e) {
      throw Exception('인증 실패: ${e.toString()}');
    }
  }

  // 사용자가 입력한 정보로 회원가입을 진행하는 메서드
  Future<void> registerUser(String userId) async {
    if (isCodeVerified) {
      try {
        await _repository.registerUser(userId, _signUpModel.email, _signUpModel.password);
      } catch (e) {
        throw Exception('회원가입 실패: ${e.toString()}');
      }
    } else {
      throw Exception('이메일 인증이 완료되지 않았습니다. 인증 후 다시 시도하세요.');
    }
  }
}
