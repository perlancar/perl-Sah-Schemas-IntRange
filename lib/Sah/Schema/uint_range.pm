package Sah::Schema::uint_range;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Unsigned integer range (sequence of uints/simple ranges), e.g. 1 / 5-7 / 1,10 / 1,5-7,10',
    match => qr/\A
                (?:(?:[0-9]+)(?:\s*-\s*(?:[0-9]+))?)
                (
                    \s*,\s*
                    (?:(?:[0-9]+)(?:\s*-\s*(?:[0-9]+))?)
                )*\z/x,
    prefilters => ['IntRange::check_uint_range'],
    examples => [
        {data=>'', valid=>0},

        # single int
        {data=>'1', valid=>1},
        {data=>'-2', valid=>0,
         summary=>'Negative'},
        {data=>'1.5', valid=>0, summary=>'Float'},

        # simple int range
        {data=>'1-1', valid=>1},
        {data=>'1-2', valid=>1},
        {data=>'1 - 2', valid=>1},
        {data=>'0-100', valid=>1},
        {data=>'-1-2', valid=>0,
         summary=>"Negative"},
        {data=>'-10--1', valid=>0,
         summary=>"Negative"},
        {data=>'1-', valid=>0, summary=>'Missing end value'},
        {data=>'1-1.5', valid=>0, sumary=>'Float'},
        {data=>'9-2', valid=>0, summary=>'start value cannot be larger than end value'},
        {data=>'1-2-3', valid=>0, summary=>'Invalid simple int range syntax'},
        {data=>' 1-2 ', valid=>0, summary=>'Leading and trailing whitespace is currently not allowed'},

        # simple int seq
        {data=>'1,2', valid=>1},
        {data=>'1 , 2', valid=>1},
        {data=>'1,2,-3,4', valid=>0,
         summary=>"Negative"},
        {data=>'1,2,-3,4.5', valid=>0, summary=>'Float'},
        {data=>'1,', valid=>0, summary=>'Dangling comma is currently not allowed'},
        {data=>'1,,2', valid=>0, summary=>'Multiple commas are currently not allowed'},

        # seq of ints/simple int ranges
        {data=>'1,2-5', valid=>1},
        {data=>'-1,-2-5,7,9-9', valid=>0,
         summary=>"Negative"},
        {data=>'1,9-2', valid=>0, summary=>'start value cannot be larger than end value'},

    ],
}, {}];

1;
# ABSTRACT:
