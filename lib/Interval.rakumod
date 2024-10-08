use v6.d;

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

=begin pod

=head1 NAME

Interval - a DateTime that has intervals

=head1 SYNOPSIS

=begin code :lang<raku>

use Interval;          # just export the Interval class

my $a = Interval.new(2020,1,1,0,0,0);   # from 2020, interval of 1 hour
say $a;  # 2020-01-01T00:00:00Z
$a++;    # 2020-01-01T01:00:00Z         # one hour later
say $a.seconds;  # 3600

my $b = Interval[60].new(time);         # from now, interval of 1 minute
say $b;  # 2020-04-03T11:42:09Z
$b += 10;
say $b;  # 2020-04-03T11:52:09Z         # ten minutes later

use Interval :refine;   # lexical refinement of the DateTime class

my $c = DateTime[60].new(time);         # from now, interval of 1 minute
say $c;  # 2020-04-03T11:42:09Z
$c += 10;
say $c;  # 2020-04-03T11:52:09Z         # ten minutes later

=end code

=head1 DESCRIPTION

The C<Interval> class is a parameterizable subclass of C<DateTime> that
incorporates interval information (in seconds), and the C<.succ> and C<.pred>
methods, which allow it to be used as endpoints in C<Range> (aka C<..>) or
series (aka C<...>).  Or allow it to be incremented or decremented to get
to after the interval.  Or add / subtract a given number of intervals.

The parameterization value is in seconds and defaults to C<3600>, aka 1 hour.

=head1 LEXICAL REFINEMENT

You can also use the C<Interval> class with the C<:refine> parameter.  This
will "augment" the C<DateTime> class in the lexical scope in which the C<use>
statement is located.  This allows one to not to have to change existing code
using the C<DateTime> class, while still having the added functionality of
the C<Interval> class.

Please note that the use of lexical refinement is an experiment for now, until
it has proven its worth.

=head1 METHODS

=head2 succ

Produces the "next" C<Interval> object.

=head2 pred

Produces the "previous" C<Interval> object.

=head2 seconds

Returns the number of seconds of the interval.

=head1 OPERATORS

=head1 infix:<+>

=begin code :lang<raku>

my $b = Interval[60].new(time);         # from now, interval of 1 minute
say $b;  # 2020-04-03T11:42:09Z
$b += 10;
say $b;  # 2020-04-03T11:52:09Z         # ten minutes later

=end code

Allows adding a number of steps of the interval.

=head1 infix:<->

Allows subtracting a number of steps of the interval.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Interval .
Comments and Pull Requests are welcome.

If you like this module, or what I'm doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2020, 2021, 2024 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
