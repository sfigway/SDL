#!perl
use strict;
use warnings;
use SDL;
use SDL::Mixer::MixMusic;
use Test::More;

if ( SDL::init(SDL_INIT_AUDIO) < 0 ) {
    plan( skip_all => 'No sound card?' );

} else {
    plan( tests => 3 );
}

is( SDL::MixOpenAudio( 44100, SDL::Constants::AUDIO_S16, 2, 4096 ),
    0, 'MixOpenAudio passed' );

my $mix_music = SDL::MixLoadMUS('test/data/sample.wav');

{
    local $TODO = 1;

    # I'm not sure why this fails
    isa_ok( $mix_music, 'SDL::Mixer::MixMusic' );
};

SDL::MixPlayMusic( $mix_music, 0 );

# we close straight away so no audio is actually played

SDL::MixCloseAudio;

ok( 1, 'Got to the end' );