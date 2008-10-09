# $Id: /mirror/coderepos/lang/perl/XML-LibXML-SAX-ChunkParser/trunk/lib/XML/LibXML/SAX/ChunkParser.pm 87623 2008-10-09T08:23:46.440905Z daisuke  $

package XML::LibXML::SAX::ChunkParser;
use strict;
use base qw(XML::SAX::Base);
use XML::LibXML;
use Carp qw(croak);

our $VERSION = '0.00003';

sub parse_chunk {
    my ($self, $chunk) = @_;
    my $options = $self->{ParserOptions};
    if (! $options) {
        $options = {};
        $options->{LibParser} = XML::LibXML->new;
        $self->{ParserOptions} = $options;
    }
    my $parser = $options->{LibParser};
    $parser->set_handler($self);

    eval {
        $parser->parse_chunk( $chunk );
    };

    if ( $parser->{SAX}->{State} == 1 ) {
        croak( "SAX Exception not implemented, yet; Data ended before document ended\n" );
    }

    # break a possible circular reference    
    $parser->set_handler( undef );
    if ( $@ ) {
        croak $@;
    }
}

sub finish {
    my $self = shift;
    my $options = $self->{ParserOptions};
    if (! $options) {
        $options->{LibParser} = XML::LibXML->new;
    }
    my $parser = $options->{LibParser};
    if ($parser) {
        $parser->parse_chunk("", 1);
    }
}

1;

__END__

=head1 NAME

XML::LibXML::SAX::ChunkParser - Parse XML Chunks Via LibXML SAX

=head1 SYNOPSIS

  local $XML::SAX::ParserPackage = 'XML::LibXML::SAX::ChunkParser';
  my $parser = XML::SAX::ParserFactory->new(Handler => $myhandler);

  $parser->parse_chunk($xml_chunk);

=head1 DESCRIPTION

XML::LibXML::SAX::ChunkParser uses XML::LibXML's parse_chunk (as opposed to
parse_xml_chunk/parse_balanced_chunk), which XML::LibXML::SAX uses.

Its purpose is to simply keep parsing possibly incomplete XML fragments,
for example, from a socket.

=head1 METHODS

=head2 parse_chunk

Parses possibly incomplete XML fragment

=head2 finish

Explicitly tell the parser that we're done parsing

=head1 AUTHOR

Daisuke Maki C<< <daisuke@endeworks.jp> >>

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut