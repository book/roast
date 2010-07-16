use v6;
use Test;

plan *;

# this test file contains tests for line numbers, among other things
# so it's extremely important not to randomly insert or delete lines.


my $baseline = 10;

isa_ok callframe(), CallFrame, 'callframe() returns a CallFrame';

sub f() {
    is callframe().line, $baseline + 5, 'callframe().line';
    ok callframe().file ~~ /« callframe »/, '.file';

    #?rakudo skip '.inline'
    nok callframe().inline, 'explicitly entered block (.inline)';

    is callframe(1).my.<$x>, 42, 'can access outer lexicals via .my';

    # Note:  According to S02, this should probably fail unless
    # $x is marked 'is dynamic'.
    callframe(1).my.<$x> = 23;
}

my $x = 42;

f();

is $x, 23, '$x remained unmodified';

done_testing();

# vim: ft=perl6 number
