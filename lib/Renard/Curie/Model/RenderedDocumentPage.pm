package Renard::Curie::Model::RenderedDocumentPage;

use Moo;
use Path::Tiny;

has [ qw(width height) ] => (
	is => 'lazy' # _build_width _build_height
);

has zoom_level => ( is => 'rw' );

has png_data => ( is => 'rw', required => 1 );

has cairo_image_surface => (
	is => 'lazy', # _build_cairo_image_surface
);

sub _build_cairo_image_surface {
	my ($self) = @_;

	# TODO build in-memory
	my $png_filename = path('test.png');
	$png_filename->spew( $self->png_data );
	my $img = Cairo::ImageSurface->create_from_png( $png_filename );
	$png_filename->remove;

	return $img;
}

sub _build_width {
	my ($self) = @_;
	$self->cairo_image_surface->get_width;
}

sub _build_height {
	my ($self) = @_;
	$self->cairo_image_surface->get_height;
}

1;