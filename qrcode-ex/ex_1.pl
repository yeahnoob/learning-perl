#!/usr/bin/env perl
# Hash(SHA256) a string,
# and output the result as QRCode.

use Modern::Perl;
use warnings;

use Crypt::Digest::SHA256;
use Imager::QRCode;

open my $frh, "<", $ARGV[0];

my $d = Crypt::Digest::SHA256->new;
$d->addfile($frh);    # input the document
my $dhash = $d->hexdigest;
print "Document's Yaml File => Hash : ", $dhash, "\n";
my $crypt_d = Crypt::Digest::SHA256->new;
$crypt_d->addfile($frh);  # the application document's file name
$crypt_d->addfile("dm_rsa.priv.pem");  # the server's private RSA key.
my $crypt_dhash = $crypt_d->hexdigest;
print "Hash => Crypt_Hash : ", $crypt_dhash, "\n";

my $qrcode_str = join '',
  ( "http://192.168.0.120:8080/doc/check?id=", $crypt_dhash);
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
my $img = $qrcode->plot($qrcode_str);
$img->write( file => "output.qrcode.png" );

# no more
