ActiveRecord::Schema.define(version: 0) do
  create_table :ungulates, force: true do |t|
    t.string :name
    t.string :congo_id
  end

  create_table :tongues, force: true do |t|
    t.string :camel_id
    t.boolean :slimy
  end

  create_table :humps, force: true do |t|
    t.string :camel_id
    t.integer :number
    t.integer :size_mm
  end

  create_table :species, force: true do |t|
    t.string :common_name
    t.string :scientific_name
  end

  create_table :pinnipeds, force: true do |t|
    t.integer :flippy_sea_creature_id
  end

  #
  create_table :liquids, force: true do |t|
  end

  create_table :chemical_compositions, force: true do |t|
    t.integer :beverage_id
  end

  create_table :flavors, force: true do |t|
    t.integer :beverage_id
  end

  create_table :articles, force: true do |t|
    t.string :heading
  end

  create_table :posts, force: true do |t|
    t.string :title
  end
end
