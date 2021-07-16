package Sah::Schema::simple_int_seq;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Simple integer sequence, e.g. 1,3,12',
    match => qr/\A(?:-?[0-9]+)(?:\s*,\s*(?:-?[0-9]+))*\z/,
    #prefilters => ['IntRange::check_simple_int_seq'],
    description => <<'_',

TODO: infinite sequence, e.g. '1,2,3,...'.

_
    examples => [
        {data=>'', valid=>0},
        {data=>'1-2', valid=>0, summary=>'A range m-n is not valid in simple integer sequence'},
        {data=>'1,', valid=>0, summary=>'Dangling comma is currently not allowed'},
        {data=>'1,,2', valid=>0, summary=>'Multiple commas are currently not allowed'},
        {data=>'1.2', valid=>0, summary=>'Float'},

        {data=>'1', valid=>1},
        {data=>'1,2', valid=>1},
        {data=>'1 , 2', valid=>1},
        {data=>'1,2,-3,4', valid=>1},
    ],
}, {}];

1;
# ABSTRACT:
