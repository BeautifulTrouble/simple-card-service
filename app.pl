#!/usr/bin/env perl
use Mojolicious::Lite;
use Mojo::UserAgent;
use Data::Dumper;

my $ua = Mojo::UserAgent->new;

helper parse_meta => sub {
    my $c   = shift;
    my $url = shift;
    my $data;
    my $tx = $ua->get( $url );
    if ( my $res = $tx->success ) {
        $data = {
            title => $res->dom->at( 'meta[property="og:title"]' )
                ->attr( 'content' ) || $res->dom->at( 'title' )->text,
            teaser => $res->dom->at( 'meta[property="og:description"]' )
                ->attr( 'content' ),
            image => $res->dom->at( 'meta[property="og:image"]' )
                ->attr( 'content' ),
            site => $res->dom->at( 'meta[property="og:site_name"]' )
                ->attr( 'content' )
        };
    }
    else {
        my $err = $tx->error;
        $data = {
            error => "Connection error: $err->{message}"
        };
    }
    return $data;
};

get '/' => sub {
    my $c   = shift;
    my $url = $c->param( 'url' );
    my $data = $c->parse_meta( $url );
    $c->render( json => { url => $url, data => $data } );
};
app->start;
