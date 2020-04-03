use v6.c;

class Interval:ver<0.0.1>:auth<cpan:ELIZABETH> is DateTime {
    my \interval = Duration.new(3600);
    method succ() { self + interval }
    method pred() { self - interval }
    method seconds(--> 3600) { }

    my role Intervaller[\seconds] {
        my \interval = Duration.new(seconds);
        method succ() { self + interval }
        method pred() { self - interval }
        method seconds() { seconds }
    }

    method ^parameterize(\type, \seconds) {
        my \mixed-in = type.^mixin(Intervaller[seconds]);
        mixed-in.^set_name(type.^name ~ '[' ~ seconds ~ ']');
        mixed-in
    }
}

multi sub infix:<+>(Interval:D \a, Int:D \b) is export {
    a + Duration.new(a.seconds * b)
}
multi sub infix:<->(Interval:D \a, Int:D \b) is export {
    a - Duration.new(a.seconds * b)
}

=begin pod

=head1 NAME

Interval - a DateTime that has intervals

=head1 SYNOPSIS

  use Interval;

  my $a = Interval.new(2020,1,1,0,0,0);   # from 2020, interval of 1 hour
  say $a;  # 2020-01-01T00:00:00Z
  $a++;    # 2020-01-01T01:00:00Z         # one hour later
  say $a.seconds;  # 3600

  my $b = Interval[60].new(time);         # from now, interval of 1 minute
  say $b;  # 2020-04-03T11:42:09Z
  $b += 10;
  say $b;  # 2020-04-03T11:52:09Z         # ten minutes later

=head1 DESCRIPTION

The C<Interval> class is a parameterizable subclass of C<DateTime> that
incorporates interval information (in seconds), and the C<.succ> and C<.pred>
methods, which allow it to be used as endpoints in C<Range> (aka C<..>) or
series (aka C<...>).  Or allow it to be incremented or decremented to get
to after the interval.  Or add / subtract a given number of intervals.

The parameterization value is in seconds and defaults to C<3600>, aka 1 hour.

=head1 METHODS

=head2 succ

Produces the "next" C<Interval> object.

=head2 pred

Produces the "previous" C<Interval> object.

=head2 seconds

Returns the number of seconds of the interval.

=head1 OPERATORS

=head1 infix:<+>

  my $b = Interval[60].new(time);         # from now, interval of 1 minute
  say $b;  # 2020-04-03T11:42:09Z
  $b += 10;
  say $b;  # 2020-04-03T11:52:09Z         # ten minutes later

Allows adding a number of steps of the interval;

=head1 infix:<->

Allows subtracting a number of steps of the interval;

=head1 AUTHOR

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/Interval .
Comments and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: ft=perl6 expandtab sw=4
