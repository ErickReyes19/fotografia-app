
import 'package:provider/provider.dart';

import '../../providers/auth.provider.dart';




resetProviders(context) {
  Provider.of<AuthProvider>(context, listen: false).resetProvider();

}
