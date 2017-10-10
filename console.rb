require ( 'pry' )
require_relative ( 'models/bounties.rb' )

Bounties.delete_all

bounty_1 = Bounties.new(
  {
  'name' => 'Kurr',
  'species' => 'Omicronian',
  'homeworld' => 'Omicron Persei 8',
  'bounty_value' => '2300'
  }
)

bounty_2 = Bounties.new(
  {
  'name' => 'Mork',
  'species' => 'Unknown',
  'homeworld' => 'Unknown',
  'bounty_value' => '50000'
  }
)

bounty_3 = Bounties.new(
  {
  'name' => 'Nebula',
  'species' => 'Luphomoid',
  'homeworld' => 'Unknown',
  'bounty_value' => '30000'
  }
)

binding.pry
nil
