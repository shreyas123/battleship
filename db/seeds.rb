#create Ships
Ship.where(name: 'Carrier', length: 5).first_or_create!
Ship.where(name: 'Battleship', length: 4).first_or_create!
Ship.where(name: 'Cruiser', length: 3).first_or_create!
Ship.where(name: 'Submarine', length: 3).first_or_create!
Ship.where(name: 'Destroyer', length: 2).first_or_create!