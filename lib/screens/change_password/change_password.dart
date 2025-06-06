import 'package:flutter/material.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/utils/utils.dart';
import 'package:charging_station/widgets/widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  final _textPassController = TextEditingController();
  final _textRePassController = TextEditingController();
  final _focusPass = FocusNode();
  final _focusRePass = FocusNode();

  String? _errorPass;
  String? _errorRePass;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textPassController.dispose();
    _textRePassController.dispose();
    _focusPass.dispose();
    _focusRePass.dispose();
    super.dispose();
  }

  ///On change password
  void _changePassword() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorPass = UtilValidator.validate(_textPassController.text);
      _errorRePass = UtilValidator.validate(
        _textRePassController.text,
        match: _textPassController.text,
      );
    });
    if (_errorPass == null && _errorRePass == null) {
      final result = await AppBloc.userCubit.onChangePassword(
        _textPassController.text,
      );
      if (!mounted) return;
      if (result) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('change_password')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      Translate.of(context).translate('password'),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextInput(
                      hintText: Translate.of(
                        context,
                      ).translate('input_your_password'),
                      errorText: _errorPass,
                      focusNode: _focusPass,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      onSubmitted: (text) {
                        Utils.fieldFocusChange(
                          context,
                          _focusPass,
                          _focusRePass,
                        );
                      },
                      onChanged: (text) {
                        setState(() {
                          _errorPass = UtilValidator.validate(
                            _textPassController.text,
                          );
                        });
                      },
                      controller: _textPassController,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      Translate.of(context).translate('confirm_password'),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextInput(
                      hintText: Translate.of(
                        context,
                      ).translate('confirm_your_password'),
                      errorText: _errorRePass,
                      focusNode: _focusRePass,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onSubmitted: (text) {
                        _changePassword();
                      },
                      onChanged: (text) {
                        setState(() {
                          _errorRePass = UtilValidator.validate(
                            _textRePassController.text,
                          );
                        });
                      },
                      controller: _textRePassController,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              AppButton(
                Translate.of(context).translate('update'),
                mainAxisSize: MainAxisSize.max,
                onPressed: _changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
