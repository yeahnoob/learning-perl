#!/usr/bin/env perl
# Hash(SHA256) a string,
# and output the result as QRCode.

use Modern::Perl;
use warnings;
use autodie;

use Crypt::Digest::SHA256;
use Imager::QRCode;

open my $frh, "<", $ARGV[0];

my $d = Crypt::Digest::SHA256->new;
$d->addfile($frh);    # input the document
my $dhash = join '',
  ( "http://192.168.0.120:8080/doc/check?id=", $d->hexdigest );

my $qrcode = Imager::QRCode->new(
    size          => 4,
    margin        => 3,
    version       => 0,
    level         => 'Q',
    mode          => '8-bit',
    casesensitive => 1,
    lightcolor    => Imager::Color->new( 255, 255, 255 ),
    darkcolor     => Imager::Color->new( 0, 0, 0 ),
);
my $img = $qrcode->plot($dhash);
$img->write( file => "output.qrcode.gif" );

# no more
