package Application::Catalyst::TaggedGallery::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
	TEMPLATE_EXTENSION => '.tt',
	render_die         => 1,
);

=head1 NAME

Application::Catalyst::TaggedGallery::View::Web - TT View for Application::Catalyst::TaggedGallery

=head1 DESCRIPTION

TT View for Application::Catalyst::TaggedGallery.

=head1 SEE ALSO

L<Application::Catalyst::TaggedGallery>

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
