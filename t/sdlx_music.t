#!/usr/bin/perl -w
use strict;
use warnings;
use SDL;
use SDL::Config;

my $audiodriver;

BEGIN {
	use Config;
	if ( !$Config{'useithreads'} ) {
		print("1..0 # Skip: Perl not compiled with 'useithreads'\n");
		exit(0);
	}
	use threads;
	use threads::shared;


	use Test::More;
	use lib 't/lib';
	use SDL::TestTool;

	$audiodriver = $ENV{SDL_AUDIODRIVER};
	$ENV{SDL_AUDIODRIVER} = 'dummy' unless $ENV{SDL_RELEASE_TESTING};

	if ( !SDL::TestTool->init(SDL_INIT_AUDIO) ) {
		plan( skip_all => 'Failed to init sound' );
	} elsif ( !SDL::Config->has('SDL_mixer') ) {
		plan( skip_all => 'SDL_mixer support not compiled' );
	}
}

   use_ok('SDLx::Music', "Can load SDLx::Music");

if ($audiodriver) {
	$ENV{SDL_AUDIODRIVER} = $audiodriver;
} else {
	delete $ENV{SDL_AUDIODRIVER};
}

done_testing();