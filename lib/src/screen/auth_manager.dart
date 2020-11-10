import 'package:flutter/material.dart';

import '../model/user.dart';
import '../presenter/presenters.dart';
import '../utils/utils.dart';
import '../widget/widgets.dart';
import 'screens.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var isSignIn = true, isLoading = false;
  var image = ImageUrl(null);

  final emailController = TextEditingController(),
      passwordController = TextEditingController(),
      userNameController = TextEditingController(),
      rePasswordController = TextEditingController();

  final userNameNode = FocusNode(),
      emailNode = FocusNode(),
      passwordNode = FocusNode(),
      rePasswordNode = FocusNode();

  final formState = GlobalKey<FormState>();

  final auth = AuthPresenter(),
      storage = StoragePresenter(),
      store = StorePresenter();

  void signIn() async {
    var valid = formState.currentState.validate();
    if (!valid) return;
    closeKeyboard();
    switchLoading(true);
    var error =
        await auth.signIn(emailController.text, passwordController.text);
    if (error == null)
      Nav.pushClear(context, Home());
    else {
      switchLoading(false);
      showMsg(context, 'error please try again later ', error);
    }
  }

  void signUp() async {
    //check validation
    var valid = formState.currentState.validate();
    if (!valid) return;

    //check user image
    if (image.url == null) {
      showMsg(context, 'Please Set Profile Image',
          'Click on Camera Icon To pick on Image');
      return;
    }

    //start creating account
    switchLoading(true);
    var signUpError =
        await auth.signUp(emailController.text, passwordController.text);
    if (signUpError != null) {
      showMsg(context, 'error please try again later', signUpError);
      return;
    }

    //upload image to storage and get download link
    var imageDownloadLink =
        await storage.upLoadProfileImage(auth.currentUser.uid, image.url);
    if (imageDownloadLink == 'error') {
      await deleteUser();
      return;
    }

    //set user data to fire auth (user name , download image link)
    var updateUserDataError =
        await auth.updateProfile(userNameController.text, imageDownloadLink);
    if (updateUserDataError != null) {
      await deleteUser();
      return;
    }

    //upload user data to firestore
    var user = getSignInUser();
    var uploadUserError = await store.uploadUser(user);
    if(uploadUserError != null){
      await deleteUser();
      return;
    }
    Nav.pushClear(context, Home());
  }

  Future<void> deleteUser() async{
    await auth.deleteCurrentUser();
    switchLoading(false);
    showMsg(context, 'error', 'please try again later');
  }

  UserModel getSignInUser() {
    var currentUser = auth.currentUser;
    var user = UserModel(
      id: currentUser.uid,
      name: currentUser.displayName,
      email: currentUser.email,
      status: 'hi there, I\'m using phoenix chat app',
      onLine: true,
      image: currentUser.photoURL,
    );
    return user;
  }

  void switchScreen() => setState(() {
        isSignIn = !isSignIn;
      });

  void switchLoading(bool state) => setState(() {
        isLoading = state;
      });

  void closeKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String validate(String value, String regex, String errorMSG) {
    var valid = RegExp('^$regex\$', caseSensitive: false).hasMatch(value);
    return valid == true ? null : errorMSG;
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: closeKeyboard,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox.expand(),
              buildBackground(deviceSize)[0],
              buildBackground(deviceSize)[1],
              buildAuthManager(),
              buildLoading(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildBackground(deviceSize) {
    return [
      HeroCircle(
          type: Type.top,
          color: Palette.darkColor,
          radius: deviceSize.width / 5,
          heroTag: KaT.heraTagTopCircle),
      HeroCircle(
          type: Type.bottomSmall,
          color: Palette.darkColor,
          radius: deviceSize.width / 2,
          heroTag: KaT.heraTagBottomCircle),
    ];
  }

  Widget buildAuthManager() {
    return Column(
      children: [
        Expanded(flex: 4, child: buildTop()),
        Expanded(flex: 1, child: buildDown()),
      ],
    );
  }

  Widget buildTop() {
    return ScrollableColumn(
      children: [
        SizedBox(height: 20),
        SwitchedWidget(
            TextShadow(
              text: 'Phoenix Chat',
              fontSize: 30,
            ),
            SizedBox.shrink(),
            isSignIn),
        SwitchedWidget(
            Container(
              child: TextShadow(
                text: 'LogIn',
                fontSize: 40,
              ),
            ),
            TextShadow(
              text: 'SignUp',
              fontSize: 40,
            ),
            isSignIn),
        SizedBox(height: 20),
        SwitchedWidget(SizedBox.shrink(), ImageGetter(image), isSignIn),
        buildForm()
      ],
    );
  }

  Widget buildDown() {
    return ScrollableColumn(
      children: [
        SwitchedWidget(
            Container(child: RoundedButton(text: 'Sign In', onPress: signIn)),
            RoundedButton(text: 'Sign Up', onPress: signUp),
            isSignIn),
        SizedBox(height: 15),
        SwitchedWidget(
            Container(
              child: ClickableColumnText(
                  'don\'t have an account ?',
                  'Sign Up for free',
                  Colors.grey[800],
                  Colors.black,
                  switchScreen),
            ),
            ClickableColumnText('have an account ?', 'Sign In',
                Colors.grey[800], Colors.black, switchScreen),
            isSignIn)
      ],
    );
  }

  Widget buildForm() {
    return Form(
      key: formState,
      child: Column(
        children: [
          SwitchedWidget(SizedBox.shrink(), buildUserNameField(), isSignIn),
          SwitchedWidget(
              Container(child: buildEmailField()), buildEmailField(), isSignIn),
          SwitchedWidget(Container(child: buildPasswordField()),
              buildPasswordField(), isSignIn),
          SwitchedWidget(SizedBox.shrink(), buildRePasswordField(), isSignIn),
        ],
      ),
    );
  }

  Widget buildUserNameField() => TextForm(
        keyboardType: TextInputType.name,
        hintText: 'Enter Your Name',
        controller: userNameController,
        validate: (value) => validate(
          value,
          '[a-zA-Z0-9_ ]{2,20}',
          'please enter valid name with length between 2 and 20',
        ),
        icon: Icons.account_circle,
        currentNode: userNameNode,
        nextNode: emailNode,
      );

  Widget buildEmailField() => TextForm(
        keyboardType: TextInputType.emailAddress,
        hintText: 'Enter Your Email',
        controller: emailController,
        validate: (value) => validate(
          value,
          '[a-zA-Z0-9_]+@.+\\.com',
          'please enter valid Email',
        ),
        icon: Icons.email,
        currentNode: emailNode,
        nextNode: passwordNode,
      );

  Widget buildPasswordField() => TextForm(
        keyboardType: TextInputType.visiblePassword,
        hintText: 'Enter Your Password',
        controller: passwordController,
        validate: (value) => validate(
          value,
          '[a-zA-Z0-9_]{8,}',
          'please enter valid Password at lest 8 chars',
        ),
        icon: Icons.lock,
        currentNode: passwordNode,
        nextNode: isSignIn ? null : rePasswordNode,
      );

  Widget buildRePasswordField() => TextForm(
        keyboardType: TextInputType.visiblePassword,
        hintText: 're-enter your Password',
        controller: rePasswordController,
        validate: (value) => validate(
          value,
          passwordController.text,
          'password not same',
        ),
        icon: Icons.lock,
        currentNode: rePasswordNode,
      );

  Widget buildLoading() {
    return isLoading
        ? Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(.2),
            child: Loading(),
          )
        : SizedBox.shrink();
  }
}
