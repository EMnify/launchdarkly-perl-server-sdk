# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl LaunchDarkly.t'

#########################

# change 'tests => 2' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('LaunchDarkly') };


my $fail = 0;
foreach my $constname (qw(
	LD_CLIENT_NOT_READY LD_CLIENT_NOT_SPECIFIED LD_ERROR LD_FALLTHROUGH
	LD_FLAG_NOT_FOUND LD_MALFORMED_FLAG LD_NULL_KEY LD_OFF LD_OOM
	LD_PREREQUISITE_FAILED LD_RULE_MATCH LD_STORE_ERROR LD_TARGET_MATCH
	LD_UNKNOWN LD_USER_NOT_SPECIFIED LD_WRONG_TYPE)) {
  next if (eval "my \$a = $constname; 1");
  if ($@ =~ /^Your vendor has not defined LaunchDarkly macro $constname/) {
    print "# pass: $@";
  } else {
    print "# fail: $@";
    $fail = 1;
  }

}

ok( $fail == 0 , 'Constants' );
#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

