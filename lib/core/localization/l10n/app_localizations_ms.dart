// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'TodoKu';

  @override
  String get newTask => 'Tugasan Baharu';

  @override
  String get title => 'Tajuk';

  @override
  String get description => 'Keterangan';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String routePathNotFound(Object path) {
    return 'Laluan navigasi tidak ditemui: $path';
  }

  @override
  String get settings => 'Tetapan';

  @override
  String get theme => 'Tema';

  @override
  String currentTheme(Object mode) {
    return 'Semasa: $mode';
  }

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Cerah';

  @override
  String get themeDark => 'Gelap';

  @override
  String get language => 'Bahasa';

  @override
  String get english => 'English';

  @override
  String get malay => 'Bahasa Melayu';

  @override
  String get createNewTask => 'Cipta Tugas Baru';

  @override
  String get taskTitle => 'Tajuk Tugas';

  @override
  String get titleIsRequired => 'Tajuk wajib diisi';

  @override
  String get priority => 'Keutamaan';

  @override
  String get low => 'Rendah';

  @override
  String get medium => 'Sederhana';

  @override
  String get high => 'Tinggi';

  @override
  String get starts => 'Mula';

  @override
  String get setDueDate => 'Tetapkan Tarikh Akhir';

  @override
  String get due => 'Tamat';

  @override
  String get saveTask => 'Simpan Tugas';

  @override
  String get todoList => 'Senarai Tugasan';

  @override
  String get completedTasks => 'Tugasan Selesai';

  @override
  String get taskMarkedAsCompleted => 'Tugasan Ditanda Sebagai Selesai';

  @override
  String get taskMarkedAsIncomplete => 'Tugasan Ditanda Sebagai Belum Selesai';

  @override
  String get undo => 'Buat Asal';

  @override
  String get taskDeleted => 'Tugasan Dipadam';

  @override
  String get noCompletedTasksYet => 'Tiada Tugasan Selesai Lagi';

  @override
  String get allDoneForNow => 'Semua Selesai Buat Masa Ini';

  @override
  String get completeYourTaskRightNow => 'Selesaikan Tugasan Anda Sekarang!';

  @override
  String get createANewTaskRightNow => 'Cipta Tugasan Baru Sekarang!';

  @override
  String get tagsLabel => 'Tag (Dipisahkan Dengan Koma)';

  @override
  String get tagsHint => 'cth. Kerja, Peribadi, Membeli-belah';

  @override
  String get tagTooLongError => 'Tag individu tidak boleh melebihi 15 aksara';

  @override
  String get tooManyTagsError => 'Anda boleh menambah maksimum 5 tag';

  @override
  String get editTask => 'Edit Tugasan';

  @override
  String get updateTask => 'Kemas Kini Tugasan';
}
