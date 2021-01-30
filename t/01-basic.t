use v6.*;
use Test;
use Interval;

plan 12;

my $a = Interval.new(2020,1,1,0,0,0);
isa-ok $a, Interval, 'is it an Interval object';
isa-ok $a, DateTime, 'is it a DateTime object';

is-deeply $a.succ, Interval.new(2020,1,1,1,0,0), "next value ok";
is-deeply $a.pred, Interval.new(2019,12,31,23,0,0), "previous value ok";
is-deeply $a.seconds, 3600, "the interval value ok";

is-deeply $a + 10, Interval.new(2020,1,1,10,0,0), 'does addition work';
is-deeply $a - 10, Interval.new(2019,12,31,14,0,0), 'does subtraction work';

my $b = Interval[60].new(2020,1,1,0,0,0);
is-deeply $b.succ, Interval[60].new(2020,1,1,0,1,0), "next value ok";
is-deeply $b.pred, Interval[60].new(2019,12,31,23,59,0), "previous value ok";
is-deeply $b.seconds, 60, "the interval value ok";

is-deeply $b + 10, Interval[60].new(2020,1,1,0,10,0), 'does addition work';
is-deeply $b - 10, Interval[60].new(2019,12,31,23,50,0), 'does subtraction work';

# vim: expandtab shiftwidth=4
