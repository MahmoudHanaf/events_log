import 'package:charging_station/models/model_request_otp.dart';
import 'package:charging_station/screens/home/home.dart';
import 'package:charging_station/screens/otp_verification/otp_verification.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/utils/utils.dart';
import 'package:charging_station/widgets/widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _focusID = FocusNode();
  final _focusPass = FocusNode();
  final _focusEmail = FocusNode();

  final bool _showPassword = false;
  String? _errorID;
  String? _errorPass;
  String? _errorEmail;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textIDController.dispose();
    _textPassController.dispose();
    _textEmailController.dispose();
    _focusID.dispose();
    _focusPass.dispose();
    _focusEmail.dispose();
    super.dispose();
  }

  ///On sign up
  void _signUp() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorID = UtilValidator.validate(_textIDController.text);
      _errorPass = UtilValidator.validate(_textPassController.text);
      _errorEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
    });
    if (_errorID == null && _errorPass == null && _errorEmail == null) {
      final result = await AppBloc.userCubit.onRegister(
        username: _textIDController.text,
        password: _textPassController.text,
        email: _textEmailController.text,
      );
      if (!mounted || !result) return;
      Navigator.pop(context, [
        _textIDController.text,
        _textPassController.text,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        // centerTitle: true,
        //  title: Text(Translate.of(context).translate('sign_up')),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          //  alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                Center(
                  child: Text(
                    Translate.of(context).translate('Register'),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  Translate.of(context).translate('Name'),
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
                ),
                AppTextInput(
                  hintText: "Enter your name",
                  errorText: _errorID,
                  controller: _textIDController,
                  focusNode: _focusID,
                  // icon: Icons.person,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorID = UtilValidator.validate(_textIDController.text);
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(context, _focusID, _focusPass);
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('Mobile Number'),
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(
                    context,
                  ).translate('Enter your Mobile Number'),
                  errorText: _errorPass,
                  // onChanged: (text) {
                  // setState(() {
                  // _errorPass = UtilValidator.validate(
                  // _textPassController.text,
                  // );
                  // });
                  // },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(context, _focusPass, _focusEmail);
                  },
                  // icon: Icons.phone_android_outlined,
                  // trailing: GestureDetector(
                  // dragStartBehavior: DragStartBehavior.down,
                  // onTap: () {
                  // setState(() {
                  // _showPassword = !_showPassword;
                  // });
                  // },
                  // child: Icon(
                  // _showPassword ? Icons.visibility : Icons.visibility_off,
                  // ),
                  // ),
                  // obscureText: !_showPassword,
                  controller: _textPassController,
                  focusNode: _focusPass,
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('email'),
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('Enter your Email'),
                  errorText: _errorEmail,
                  focusNode: _focusEmail,
                  onSubmitted: (text) {
                    _signUp();
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorEmail = UtilValidator.validate(
                        _textEmailController.text,
                        type: ValidateType.email,
                      );
                    });
                  },
                  controller: _textEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 80),
                AppButton(
                  Translate.of(context).translate('sign_up'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => OtpVerification(
                              requestOTPModel: RequestOTPModel(
                                email: "ha2717760@gmail.com",
                                onVerify: (String otp) async {
                                  return Future.value([otp]);
                                  // TODO: Implement your verification logic here using the 'otp' parameter
                                },
                              ),
                            ),
                      ), //Home()),
                    );
                  }, // _signUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
