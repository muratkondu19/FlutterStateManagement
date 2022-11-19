// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_state_management/feature/product/constant/image_enum.dart';
import 'package:flutter_state_management/feature/product/model/state/user_context.dart';
import 'package:flutter_state_management/feature/product/utility/input_decoration.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../product/padding/page_padding.dart';
import '../viewModel/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final String rememberMe = 'Remember me';

  final String login = 'Login';

  final String enterUsername = 'Enter Username';

  final String username = 'Username';

  final String login2 = 'Login';

  late final LoginViewModel _loginViewModel;
  @override
  void initState() {
    super.initState();
    _loginViewModel = LoginViewModel();
    print(context.read<UserContext>().name); //güncellenmiş data gözükmektedir.
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loginViewModel,
      builder: (context, child) {
        return _bodyView(context);
      },
    );
  }

  Scaffold _bodyView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _loadingWidget(),
        title: Text(context.read<UserContext>().name ?? ''),
      ),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AnimatedContainer(
                duration: context.durationLow,
                height: context.isKeyBoardOpen ? 0 : context.dynamicHeight(0.2),
                width: context.dynamicWidth(0.3),
                child: ImageEnums.door.toImage),
            Text(
              login2,
              style: context.textTheme.headline4,
            ),
            TextField(decoration: ProjectInputs('$enterUsername', '$username')),
            ElevatedButton(
                onPressed: context.watch<LoginViewModel>().isLoading
                    ? null
                    : () {
                        //context.read<LoginViewModel>().controlTextValue();
                        _loginViewModel.controlTextValue();
                      },
                child: Center(child: Text(login))),
            CheckboxListTile(
                title: Text('$rememberMe'),
                value: _loginViewModel.isChechBoxOkey, //context.watch<LoginViewModel>().isChechBoxOkey,
                //herhangi bir class içerisindeki değişkeni dinleyebilir
                onChanged: (value) {
                  _loginViewModel.chechBoxChange(value ?? false);
                  //context.read<LoginViewModel>().chechBoxChange(value ?? false);
                  //read ile değişkenin durumuna erişilir.
                })
          ],
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    //Consumer Kullanımı
    return Consumer<LoginViewModel>(builder: (context, value, child) {
      return value.isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox();
    });

    //Selector Kullanımı
    // return Selector<LoginViewModel, bool>(builder: (context, value, child) {
    //   return value ? const Center(child: CircularProgressIndicator()) : SizedBox();
    // }, selector: (context, viewModel) {
    //   return viewModel.isLoading == true;
    // });
  }
}
