import 'dart:io';

import 'package:medvisual/src/data/remote/models/visual_disease_model/visual_disease_model.dart';

abstract interface class VisualRepository {
  Future<List<VisualDisease>> makeVerdict(
      File image, List<String> presumedDiseases);
}
