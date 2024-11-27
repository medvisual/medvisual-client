import 'package:medvisual/src/data/models/disease/disease.dart';
import 'package:medvisual/src/data/models/page_meta/page_meta.dart';

class DiseasesPage {
  DiseasesPage({required this.diseases, required this.meta});
  final List<Disease> diseases;
  final PageMeta meta;
}
