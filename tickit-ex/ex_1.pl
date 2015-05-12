#!/usr/bin/env perl

use Modern::Perl;
use warnings;

use Tickit;
use Tickit::Pen;

my $tickit = Tickit->new;

my $rootwin = $tickit->rootwin;

$rootwin->set_on_expose(
    sub {
        my ( $win, $rb, $rect ) = @_;

        $rb->clear;

        $rb->text_at(
            int( $win->lines / 2 ), int( ( $win->cols - 12 ) / 2 ),
            "Hello, world"

        );

    }
);
$rootwin->set_on_geom_changed( sub { shift->expose } );
$rootwin->set_pen( Tickit::Pen->new( fg => "white" ) );

$rootwin->expose;
$tickit->run;
