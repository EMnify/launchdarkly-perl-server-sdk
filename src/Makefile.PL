use v5.26.1;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'LaunchDarkly',
    VERSION_FROM      => 'lib/LaunchDarkly.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/LaunchDarkly.pm', # retrieve abstract from module
    AUTHOR            => 'Miklos Tirpak <miklos.tirpak@emnify.com>',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #https://metacpan.org/pod/Module::Build::API
    LIBS              => ['-lpcre -lcurl -lldserverapi'],
    DEFINE            => '-I../ -I../c-server-sdk/include',
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    #OBJECT            => 'LaunchDarkly.o',
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = (qw(),
              {name=>"LD_CLIENT_NOT_READY", macro=>"1"},
              {name=>"LD_CLIENT_NOT_SPECIFIED", macro=>"1"},
              {name=>"LD_ERROR", macro=>"1"},
              {name=>"LD_FALLTHROUGH", macro=>"1"},
              {name=>"LD_FLAG_NOT_FOUND", macro=>"1"},
              {name=>"LD_MALFORMED_FLAG", macro=>"1"},
              {name=>"LD_NULL_KEY", macro=>"1"},
              {name=>"LD_OFF", macro=>"1"},
              {name=>"LD_OOM", macro=>"1"},
              {name=>"LD_PREREQUISITE_FAILED", macro=>"1"},
              {name=>"LD_RULE_MATCH", macro=>"1"},
              {name=>"LD_STORE_ERROR", macro=>"1"},
              {name=>"LD_TARGET_MATCH", macro=>"1"},
              {name=>"LD_UNKNOWN", macro=>"1"},
              {name=>"LD_USER_NOT_SPECIFIED", macro=>"1"},
              {name=>"LD_WRONG_TYPE", macro=>"1"});
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'LaunchDarkly',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
