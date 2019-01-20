package Application::Catalyst::TaggedGallery::Model::TaggedFiles;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

=head1 NAME

Application::Catalyst::TaggedGallery::Model::TaggedFiles - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.


=encoding utf8

=head1 AUTHOR

,,,
=cut

our $AUTOLOAD;
has 'Persistent_TF' => (
	is => 'rw',

	# TODO arg
	isa => 'SubSystem::TaggedFiles::CachedDB',
);
has 'url_path_to_track_okazu' => ( is => 'rw', );
__PACKAGE__->config( class => 'SubSystem::TagForSubject::CachedDB' );

sub initialize_after_setup {
	my ( $self, $c ) = @_;
	use Data::Dumper;
	use SubSystem::TaggedFiles::CachedDB;

	$c->log->debug( 'Initialising Persistent_TFS' );

	$self->Persistent_TF( SubSystem::TaggedFiles::CachedDB->new( $c->config->{'Model::TaggedFiles'} ) );

	# TODO shared DBH
	$self->Persistent_TF->IdForPath->_last_insert( "select LAST_INSERT_ID()" );
	$self->Persistent_TF->TagForSubject->_last_insert( "select LAST_INSERT_ID()" );
}

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
