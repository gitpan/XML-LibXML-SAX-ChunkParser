use strict;
use inc::Module::Install;

name('XML-LibXML-SAX-ChunkParser');
all_from('lib/XML/LibXML/SAX/ChunkParser.pm');

requires 'XML::LibXML', 1.66;
requires 'XML::SAX';

test_requires 'Test::More';
test_requires 'Test::Compile';

auto_include;
WriteAll;

#sub MY::install {
#    package MY;
#    my $script = shift->SUPER::install(@_);
#    if (ExtUtils::MakeMaker::prompt(
#        "Do you want to modify ParserDetails.ini?", 'Y')
#        =~ /^y/i) {
#        $script =~ s/install :: (.*)$/install :: $1 install_sax_driver/m;
#        $script .= <<"INSTALL";
#  
#install_sax_driver :
#\t\@\$(PERL) -MXML::SAX -e "XML::SAX->add_parser(q(\$(NAME)))->save_parsers()"
#  
#INSTALL
#    }
#    return $script;
#}