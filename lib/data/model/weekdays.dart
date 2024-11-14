enum Weekday {
  monday("Mon", DateTime.monday),
  tuesday("Tue", DateTime.tuesday),
  wednesday("Wed", DateTime.wednesday),
  thursday("Thu", DateTime.thursday),
  friday("Fri", DateTime.friday),
  saturday("Sat", DateTime.saturday),
  sunday("Sun", DateTime.sunday);

  static Weekday today(int day) => values.firstWhere((d) => d.position == day);

  final String abbreviation;
  final int position;
  const Weekday(this.abbreviation, this.position);
}

sealed class Day {
  final String abbreviation;
  const Day(this.abbreviation);
}

sealed class Weekdays extends Day {
  Weekdays(super.abbreviation);
}

sealed class Weekend extends Day {
  Weekend(super.abbreviation);
}

class Monday extends Weekdays {
  Monday() : super("Mon");
}

class Tuesday extends Weekdays {
  Tuesday() : super("Tue");
}

class Wednesday extends Weekdays {
  Wednesday() : super("Wed");
}

class Thursday extends Weekdays {
  Thursday() : super("Thu");
}

class Friday extends Weekdays {
  Friday() : super("Fri");
}

class Saturday extends Weekend {
  Saturday() : super("Sat");
}

class Sunday extends Weekend {
  Sunday() : super("Sun");
}
