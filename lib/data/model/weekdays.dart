enum Weekday {
  monday("Mon"),
  tuesday("Tue"),
  wednesday("Wed"),
  thursday("Thu"),
  friday("Fri"),
  saturday("Sat"),
  sunday("Sun");

  final String abbreviation;
  const Weekday(this.abbreviation);
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
