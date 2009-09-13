Factory.sequence :name do |n|
  "name_nr_#{n}"
end

Factory.sequence :identifier do |n|
  "xxx_#{n}"
end

Factory.define(:user) do |f|
  f.identifier { Factory.next(:identifier) }
  f.name { Factory.next(:name) }
end

Factory.define(:command) do |f|
  f.name 'ls'
  f.description 'show files n stuff'
end