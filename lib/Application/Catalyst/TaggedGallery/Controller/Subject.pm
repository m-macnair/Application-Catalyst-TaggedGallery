package Application::Catalyst::TaggedGallery::Controller::Subject;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Application::Catalyst::TaggedGallery::Controller::Subject - Catalyst Controller

=head1 DESCRIPTION

	An end point for interacting with a subject

=head1 METHODS

=cut

=head2 index
	Show the subject
=cut

sub index : Path : Args(0) {
	my ( $self, $c ) = @_;

	$c->response->body( 'Matched Application::Catalyst::TaggedGallery::Controller::Subject in Subject.' );
}

# TODO implement split so that an untagged file can have corresponding subjects connected
sub next_untagged : Local : Args(0) {
	my ( $self, $c ) = @_;
	my $untagged_url = $c->forward( '_shared_next_untagged' );
	$c->stash(
		{
			url => "http://" . $untagged_url
		}
	);
}

sub next_untagged_no_frame : Local : Args(0) {
	my ( $self, $c ) = @_;
	my $untagged_url = $c->forward( '_shared_next_untagged' );
	$c->response->body( "http://" . $untagged_url );
}

sub _shared_next_untagged : Private {
	my ( $self, $c ) = @_;
	my $res = $c->model( 'TaggedFiles' )->Persistent_TF->file_instance_without_subject();
	my $url;
	if ( $res->{nofiles} ) {

		$url = 'not found';

	} elsif ( $res->{fail} ) {

		#this is probably incorrect
		$url = $res->{fail};

	} else {

		#result from file_instance_without_subject without params is an array of 1
		$res = shift( @{$res->{pass}} );

		if ( $res->{source} eq 'orrick' ) {
			$res->{source} = '192.168.0.16';
		}

		$url = "$res->{source}/$res->{path}/$res->{file_name}$res->{suffix}";

		$url =~ s|//|/|;

	}

	return $url;

}

=head2 tag_subject_single
	usually through js, the subject has been assigned a single tag - that should already exist
=cut

sub tag_subject_single : Local : Args(2) {
	my ( $self, $c, $subject_id, $tag ) = @_;
	die "no subject id" unless $subject_id;

	# TODO assign_tags instead when it exists
	$c->model( 'TaggedFiles' )->Persistent_TF->TagForSubject->subject_2d_tags( $subject_id, $tag );
	$c->response->body( 'Success' );

}

=encoding utf8

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
