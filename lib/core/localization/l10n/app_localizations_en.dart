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

  @override
  String get searchTasks => 'Search Tasks or #tag...';

  @override
  String get all => 'All';

  @override
  String get category => 'Category';

  @override
  String get none => 'None';

  @override
  String get personal => 'Personal';

  @override
  String get work => 'Work';

  @override
  String get shopping => 'Shopping';

  @override
  String get health => 'Health';

  @override
  String get finance => 'Finance';

  @override
  String get projectGroups => 'Project Groups';

  @override
  String get noActiveTasksInThisGroup => 'No active tasks in this group';

  @override
  String get groupProgress => 'Group Progress';

  @override
  String targetDeadline(Object date) {
    return 'Target Deadline: $date';
  }

  @override
  String deadline(Object date) {
    return 'Deadline: $date';
  }

  @override
  String get editGroup => 'Edit Group';

  @override
  String get deleteGroup => 'Delete Group';

  @override
  String get deleteGroupQuestionMark => 'Delete Group?';

  @override
  String get allTasksInThisGroupWillAlsoBeDeletedThisCannotBeUndone =>
      'All tasks in this group will also be deleted. This cannot be undone.';

  @override
  String get editGroupDetails => 'Edit Group Details';

  @override
  String get groupName => 'Group Name';

  @override
  String get enterGroupName => 'Enter group name';

  @override
  String get noTargetDeadlineSet => 'No Target Deadline Set';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get createNewProjectGroup => 'Create New Project Group';

  @override
  String get newTaskGroup => 'New Task Group';

  @override
  String get groupNameHint => 'e.g., Work, Fitness, Errands';

  @override
  String get nameIsRequired => 'Name is required';

  @override
  String get setTargetDueDate => 'Set Target Due Date';

  @override
  String get createWorkspace => 'Create Workspace';

  @override
  String get delete => 'Delete';

  @override
  String dueDate(Object date) {
    return 'Due: $date';
  }

  @override
  String get confirm => 'Confirm';

  @override
  String get task => 'Task';
}
