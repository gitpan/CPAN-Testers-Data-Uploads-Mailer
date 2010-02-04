use Test::More;
use IO::File;
use CPAN::Testers::Data::Uploads::Mailer;

# Skip if doing a regular install
plan skip_all => "Author tests not required for installation"
    unless ( $ENV{AUTOMATED_TESTING} );

my $fh = IO::File->new('CHANGES','r')   or plan skip_all => "Cannot open CHANGES file";

plan no_plan;

my $latest = 0;
while(<$fh>) {
    next        unless(m!^\d!);
    $latest = 1 if(m!^$CPAN::Testers::Data::Uploads::Mailer::VERSION!);
    like($_, qr!\d[\d._]+\s+\d{2}/\d{2}/\d{4}!,'... version has a date');
}

is($latest,1,'... latest version not listed');
