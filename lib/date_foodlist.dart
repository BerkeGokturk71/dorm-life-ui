import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateFoodTurkish {
  String dateTurkishReturn() {
    // Yerelleştirme verilerini başlat
    final _locale = 'tr_TR';
    initializeDateFormatting(_locale, null);
    // Şu anki tarihi al
    DateTime now = DateTime.now();
    // Türkçe formatlamak için DateFormat
    String formattedDate = DateFormat('d MMMM EEEE', _locale).format(now);

    return ('$formattedDate');
  }
}
