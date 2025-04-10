import '../../modules/login_screen/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

String? token;
void printFullText(String text)
{

  Future<Null> signOut()=>CacheHelper.removeData(key: 'token').then((value)
  {
    if(value) {
      var context;
      pushAndFinish(context: context, widget: LoginScreen());
    }
  });
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

//Images
const String logo='assets/images/logo.png';