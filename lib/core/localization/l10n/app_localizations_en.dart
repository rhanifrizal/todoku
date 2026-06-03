// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TodoKu';

  @override
  String get newTask => 'New Task';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String routePathNotFound(Object path) {
    return 'Route path not found: $path';
  }

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String currentTheme(Object mode) {
    return 'Current: $mode';
  }

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get malay => 'Bahasa Melayu';

  @override
  String get createNewTask => 'Create New Task';

  @override
  String get taskTitle => 'Task Title';

  @override
  String get titleIsRequired => 'Title is required';

  @override
  String get priority => 'Priority';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get starts => 'Starts';

  @override
  String get setDueDate => 'Set Due Date';

  @override
  String get due => 'Due';

  @override
  String get saveTask => 'Save Task';

  @override
  String get todoList => 'To do List';

  @override
  String get completedTasks => 'Completed Task';

  @override
  String get taskMarkedAsCompleted => 'Task Marked As Completed';

  @override
  String get taskMarkedAsIncomplete => 'Task Marked As Incompleted';

  @override
  String get undo => 'Undo';

  @override
  String get taskDeleted => 'Task Deleted';

  @override
  String get noCompletedTasksYet => 'No Completed Tasks Yet';

  @override
  String get allDoneForNow => 'All Done For Now';

  @override
  String get completeYourTaskRightNow => 'Complete Your Task Right Now!';

  @override
  String get createANewTaskRightNow => 'Create a New Task Right Now!';

  @override
  String get tagsLabel => 'Tags (Comma Separated)';

  @override
  String get tagsHint => 'e.g. Work, Personal, Shopping';

  @override
  String get tagTooLongError => 'Individual tags cannot exceed 15 characters';

  @override
  String get tooManyTagsError => 'You can add a maximum of 5 tags';

  @override
  String get editTask => 'Edit Task';

  @override
  String get updateTask => 'Update Task';
}
