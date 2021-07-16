package Sah::Schema::simple_uint_range;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Simple unsigned integer range, e.g. 1-10',
    match => qr/\A(?:[0-9]+)\s*-\s*(?:[0-9]+)\z/,
    prefilters => ['IntRange::check_simple_uint_range'],
    examples => [
        {data=>'', valid=>0},
        {data=>'1', valid=>0},
        {data=>'-2', valid=>0},

        {data=>'1-1', valid=>1},
        {data=>'1-2', valid=>1},
        {data=>'1 - 2', valid=>1},
        {data=>'0-100', valid=>1},
        {data=>'-1-2', valid=>0,
         summary=>'Negative'},
        {data=>'-10--1', valid=>0,
         summary=>'Negative'},

        {data=>'1-', valid=>0},
        {data=>'1-1.5', valid=>0, sumary=>'Float'},
        {data=>'9-2', valid=>0, summary=>'start value cannot be larger than end value'},
        {data=>'1-2-3', valid=>0},
        {data=>' 1-2 ', valid=>0, summary=>'Leading and trailing whitespace is currently not allowed'},
    ],
}, {}];

1;
# ABSTRACT:
