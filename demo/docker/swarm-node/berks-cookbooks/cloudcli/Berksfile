source "https://supermarket.chef.io"

metadata

group :integration do
  cookbook "apt"
  cookbook "yum"
  cookbook 'node_dump', path: 'test/fixtures/cookbooks/node_dump'
  cookbook 'test_get', path: 'test/fixtures/cookbooks/test_get'
  cookbook 'test_virtualenv', path: 'test/fixtures/cookbooks/test_virtualenv'
  cookbook 'test_credentials', path: 'test/fixtures/cookbooks/test_credentials'
end
