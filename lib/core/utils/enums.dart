enum SortOptions {
  aZ,
  zA,
  dateRecent,
  dateOld;

  String map() {
    switch (this) {
      case SortOptions.aZ:
        return 'title';
      case SortOptions.zA:
        return '-title';
      case SortOptions.dateRecent:
        return 'created_at';
      case SortOptions.dateOld:
        return '-created_at';
    }
  }
}

enum ViewOptions {
  list,
  grid,
}

// enum AppearanceMode {
//   device,
//   light,
//   dark,
// }

enum ProductComponents {
  generalInfo,
  salesChannel,
  addVariant,
  editVariants,
  editOptions,
  editAttributes,
  editThumbnail,
  editMedia,
}

enum UserRole {
  admin('admin'),
  member('member'),
  developer('developer');

  final String value;

  const UserRole(this.value);

  factory UserRole.fromString(String value) {
    if (value == 'admin') {
      return UserRole.admin;
    } else if (value == 'developer') {
      return UserRole.developer;
    } else {
      return UserRole.member;
    }
  }
}

enum DateType { day, month }

enum DateFilterType {
  isInTheLast,
  isOlderThan,
  isAfter,
  isBefore,
  isEqualTo;

  String name() {
    switch (index) {
      case 0:
        return 'Is in the last';
      case 1:
        return 'Is older than';
      case 2:
        return 'Is after';
      case 3:
        return 'Is before';
      case 4:
        return 'Is equal to';
      default:
        return 'Is in the last';
    }
  }
}
