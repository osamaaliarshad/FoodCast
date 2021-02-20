import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/services/database.dart';

final databaseProvider = Provider((ref) => Database());
