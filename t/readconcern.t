#
#  Copyright 2009-2013 MongoDB, Inc.
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

use strict;
use warnings;
use Test::More 0.96;
use Test::Fatal;

use MongoDB;
use Tie::IxHash;

use lib "t/lib";
use MongoDBTest qw/skip_unless_mongod build_client get_test_db server_type/;

skip_unless_mongod();

my $conn = build_client();
my $testdb = get_test_db($conn);
my $server_type = server_type($conn);
my $coll = $testdb->get_collection("test_coll");

my @levels = qw/local majority/;

#   subtest "read concern connection string" => sub {
#
#       my $conn2 = build_client(
#           host =>
#             "mongodb://localhost/?readConcern=majority",
#       );
#       my $rp = $conn2->read_concern;
#       is( $rp->{level}, 'majority', "readConcern from connection string" ); 
#
#   };
#
#   subtest "read concern on cursor" => sub {
#       for my $l ( @levels ) {
#           my $cur = $coll->find()->read_concern({level => $l});
#           is_deeply( $cur->query->read_preference, 
#                      { level => $l },
#                      "read concern set"
#           );
#       }
#   };

subtest "read concern on server" => sub {
    $coll->drop;
    $coll->insert_one({ a => 1 });
    is( $coll->count, 1, "one doc in collection");
    $coll->{read_concern} = {level => 'majority'};
    my $cursor = $coll->find( {} );
    $cursor->next; 
    is(1, 1, 'dummy test');
};

done_testing;
