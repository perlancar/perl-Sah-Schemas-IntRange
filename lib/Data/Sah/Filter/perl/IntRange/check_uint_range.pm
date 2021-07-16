package Data::Sah::Filter::perl::IntRange::check_uint_range;

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
        summary => 'Check the syntax of uint_range',
        might_fail => 1,
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_filter} = join(
        "",
        "do { ", (
            "my \$tmp = $dt; ",
            "my \$r = [undef, \$tmp]; ",
            "while (length \$tmp) { ", (
                "if (\$tmp =~ s/\\A(?:\\s*,\\s*)?(?:([0-9]+)\\s*-\\s*([0-9]+)|(-?[0-9]+))//) { ", (
                    "if (defined(\$2) && \$1 > \$2) { \$r = [\"Start value must not be greater than end value: \$1-\$2\", \$tmp]; last }"),
                "} else { ", (
                    "\$r = [\"Invalid syntax in range, please use a / a,b,c / a-b / a,b-c,d syntax only\"]; last; "),
                "} ", ),
            "} ",
            "\$r; ", ),
        "}",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$
