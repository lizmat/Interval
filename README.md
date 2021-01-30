NAME
====

Interval - a DateTime that has intervals

SYNOPSIS
========

    use Interval;

    my $a = Interval.new(2020,1,1,0,0,0);   # from 2020, interval of 1 hour
    say $a;  # 2020-01-01T00:00:00Z
    $a++;    # 2020-01-01T01:00:00Z         # one hour later
    say $a.seconds;  # 3600

    my $b = Interval[60].new(time);         # from now, interval of 1 minute
    say $b;  # 2020-04-03T11:42:09Z
    $b += 10;
    say $b;  # 2020-04-03T11:52:09Z         # ten minutes later

DESCRIPTION
===========

The `Interval` class is a parameterizable subclass of `DateTime` that incorporates interval information (in seconds), and the `.succ` and `.pred` methods, which allow it to be used as endpoints in `Range` (aka `..`) or series (aka `...`). Or allow it to be incremented or decremented to get to after the interval. Or add / subtract a given number of intervals.

The parameterization value is in seconds and defaults to `3600`, aka 1 hour.

METHODS
=======

succ
----

Produces the "next" `Interval` object.

pred
----

Produces the "previous" `Interval` object.

seconds
-------

Returns the number of seconds of the interval.

OPERATORS
=========

infix:<+>
=========

    my $b = Interval[60].new(time);         # from now, interval of 1 minute
    say $b;  # 2020-04-03T11:42:09Z
    $b += 10;
    say $b;  # 2020-04-03T11:52:09Z         # ten minutes later

Allows adding a number of steps of the interval;

infix:<->
=========

Allows subtracting a number of steps of the interval;

AUTHOR
======

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/Interval . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2020,2021 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

