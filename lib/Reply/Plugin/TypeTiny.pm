package Reply::Plugin::TypeTiny;

use strict;
use warnings;

BEGIN {
	$Reply::Plugin::TypeTiny::AUTHORITY = 'cpan:TOBYINK';
	$Reply::Plugin::TypeTiny::VERSION   = '0.015_03';
};

use base 'Reply::Plugin';

use Scalar::Util qw(blessed);
use Term::ANSIColor;

sub mangle_error {
	my $self  = shift;
	my ($err) = @_;
	
	if (blessed $err and $err->isa("Type::Exception::Assertion"))
	{
		my $explain = $err->explain;
		if ($explain)
		{
			print color("cyan");
			print "Type::Exception::Assertion explain:\n";
			$self->_explanation($explain, "");
			local $| = 1;
			print "\n";
			print color("reset");
		}
	}
	
	return @_;
}

sub _explanation
{
	my $self = shift;
	my ($ex, $indent)  = @_;
	
	for my $line (@$ex)
	{
		if (ref($line) eq q(ARRAY))
		{
			print "$indent * Explain:\n";
			$self->_explanation($line, "$indent   ");
		}
		else
		{
			print "$indent * $line\n";
		}
	}
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Reply::Plugin::TypeTiny - improved type constraint exceptions in Reply

=head1 DESCRIPTION

This is a small plugin to improve error messages in L<Reply>.
Not massively tested.

=begin trustme

=item mangle_error

=end trustme

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=Type-Tiny>.

=head1 SEE ALSO

L<Type::Exception::Assertion>, L<Reply>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

