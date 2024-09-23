use v6.*;
use Test;
use Interval :refine;

plan 12;

my $a = DateTime.new(2020,1,1,0,0,0);
isa-ok $a, Interval, 'is it an Interval object';
isa-ok $a, DateTime, 'is it a DateTime object';

is-deeply $a.succ, DateTime.new(2020,1,1,1,0,0), "next value ok";
is-deeply $a.pred, DateTime.new(2019,12,31,23,0,0), "previous value ok";
is-deeply $a.seconds, 3600, "the interval value ok";

is-deeply $a + 10, DateTime.new(2020,1,1,10,0,0), 'does addition work';
is-deeply $a - 10, DateTime.new(2019,12,31,14,0,0), 'does subtraction work';

my $b = DateTime[60].new(2020,1,1,0,0,0);
is-deeply $b.succ, DateTime[60].new(2020,1,1,0,1,0), "next value ok";
is-deeply $b.pred, DateTime[60].new(2019,12,31,23,59,0), "previous value ok";
is-deeply $b.seconds, 60, "the interval value ok";

is-deeply $b + 10, DateTime[60].new(2020,1,1,0,10,0), 'does addition work';
is-deeply $b - 10, DateTime[60].new(2019,12,31,23,50,0), 'does subtraction work';

# vim: expandtab shiftwidth=4
