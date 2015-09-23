#
#  Copyright 2014 MongoDB, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

package MongoDB::ReadConcern;

# ABSTRACT: Encapsulate and validate a read concern

use version;
our $VERSION = 'v0.999.999.7';

use Moo;
use MongoDB::Error;
use Types::Standard qw(
    Str
);

use namespace::clean;

=attr level

specifies the network durability of returned reads.  Defaults 
to 'local'.

=cut

has level => (
    is        => 'ro',
    isa       => Str,
    predicate => '_has_level',
    default   => 'local',
);

sub _build_as_struct {
    my ($self) = @_;
    return {
        ( $self->_has_level ? ( level => $self->level ) : () ),
    };
}

1;

__END__

=head1 SYNOPSIS

    XXX some code samples here

=head1 DESCRIPTION

XXX Write a description

=cut
