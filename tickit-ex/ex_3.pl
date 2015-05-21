#!/usr/bin/env perl

use Modern::Perl;
use warnings;
use utf8;

use Tickit;
use Tickit::Pen;

my $tickit = Tickit->new;

my $rootwin = $tickit->rootwin;

$rootwin->set_on_expose(
    sub {
        my ( $win, $rb, $rect ) = @_;

        $rb->clear;

        my @output = (
            "什么？GFW。哦，这东西它不喜欢 VPN 协议",
            int( $win->lines / 2 ),
            int( ( $win->cols - 12 ) / 2 )
        );
        $rb->text_at( $output[1], $output[2], $output[0] );
        $rb->text_at( $output[1]+1, $output[2], $output[1] );
        $rb->text_at( $output[1]+2, $output[2], $output[2] );

    }
);
$rootwin->set_on_geom_changed( sub { shift->expose } );
$rootwin->set_pen( Tickit::Pen->new( fg => "white" ) );

$rootwin->expose;
$tickit->run;
