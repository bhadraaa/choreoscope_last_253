//user_function

import 'user_det.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<UserModel>> us_list_notifier = ValueNotifier([]);
void addUser(UserModel value) {
  us_list_notifier.value.add(value);
  print(value.toString());
}
