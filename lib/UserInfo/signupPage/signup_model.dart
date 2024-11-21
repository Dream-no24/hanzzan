// 모델 파일: signup_model.dart
// 사용자 정보를 담기 위한 데이터 모델 클래스
// 이메일, 비밀번호, 인증 코드를 포함합니다.
class SignUpModel {
  String email;  // 사용자 이메일
  String password;  // 사용자 비밀번호
  String verificationCode;  // 이메일로 받은 인증 코드

  SignUpModel({
    required this.email,
    required this.password,
    required this.verificationCode,
  });
}
