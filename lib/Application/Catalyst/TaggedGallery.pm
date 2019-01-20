package Application::Catalyst::TaggedGallery;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
  -Debug
  ConfigLoader
  Static::Simple
  /;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in application_catalyst_taggedgallery.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
	name => 'Application::Catalyst::TaggedGallery',

	# Disable deprecated behavior needed by old applications
	disable_component_resolution_regex_fallback => 1,
	enable_catalyst_header                      => 1, # Send X-Catalyst header
);

__PACKAGE__->config(
	'View::TT' => {
		INCLUDE_PATH => [ __PACKAGE__->path_to( 'root', 'tt' ), ],
	},
);

# usually for models, do $things that have to occur after the base system has been established
after 'setup_components' => sub {
	my $c = shift;

	for ( keys %{$c->components} ) {
		$c->components->{$_}->initialize_after_setup( $c )
		  if $c->components->{$_}->can( 'initialize_after_setup' );
	}
};

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

Application::Catalyst::TaggedGallery - Catalyst based application

=head1 SYNOPSIS

    script/application_catalyst_taggedgallery_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Application::Catalyst::TaggedGallery::Controller::Root>, L<Catalyst>

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
