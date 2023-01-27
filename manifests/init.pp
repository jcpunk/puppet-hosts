# @summary Setup /etc/hosts
#
# @param add_entries
#   host entries to add, see example for structure
#
# @example trivial include
#   include hosts
#
# @example with elements
#   class { 'hosts':
#     add_entries                => {
#       'myhostname.example.com' => {
#         'ipv4'                 => '127.0.0.1',
#         'ipv6'                 => '::1',
#         'aliases'              => ['myhostname', 'myname'],
#         'comment'              => 'some string goes here'
#       }
#     }
#   }
class hosts (
  # lint:ignore:140chars
  Hash[Stdlib::Fqdn, Struct[{ Optional[ipv4] => Stdlib::IP::Address::V4::Nosubnet, Optional[ipv6] => Stdlib::IP::Address::V6::Nosubnet, Optional[aliases] => Array[Stdlib::Fqdn], Optional[comment] => String }]] $add_entries = {}
  # lint:endignore
) {
  file { '/etc/hosts':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('hosts/etc/hosts.epp', { 'entries' => $add_entries }),
  }
}
