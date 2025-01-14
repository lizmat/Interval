class Interval is DateTime {
    my \interval = Duration.new(3600);
    method succ(::?CLASS:D:) { self + interval }
    method pred(::?CLASS:D:) { self - interval }
    method seconds(--> 3600) { }

    my role Intervaller[\seconds] {
        my \interval = Duration.new(seconds);
        method succ(::?CLASS:D:) { self + interval }
        method pred(::?CLASS:D:) { self - interval }
        method seconds() { seconds }
    }

    method ^parameterize(\type, \seconds) {
        my \mixed-in = type.^mixin(Intervaller[seconds]);
        mixed-in.^set_name(type.^name ~ '[' ~ seconds ~ ']');
        mixed-in
    }
}

my multi sub infix:<+>(Interval:D \a, Int:D \b) is export(:DEFAULT, :refine) {
    a + Duration.new(a.seconds * b)
}
my multi sub infix:<->(Interval:D \a, Int:D \b) is export(:DEFAULT, :refine) {
    a - Duration.new(a.seconds * b)
}

BEGIN EXPORT::refine::<DateTime> := Interval;

# vim: expandtab shiftwidth=4
