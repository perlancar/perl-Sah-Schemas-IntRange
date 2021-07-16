package Data::Sah::Filter::perl::IntRange::check_simple_int_range;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 1,
        summary => 'Check the syntax of simple_int_range',
        might_fail => 1,
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = $dt; my (\$m, \$n) = \$tmp =~ /\\A(-?[0-9]+)\\s*-\\s*(-?[0-9]+)\\z/; if (!defined(\$m)) { [\"Invalid range syntax, please use m-n\", \$tmp] } elsif (\$m > \$n) { [\"Start value of range must not be greater than end value: \$tmp\", \$tmp] } else { [undef, \$tmp] } }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$
