ActiveRecord::Schema.define(version: 1) do
  create_table :users do |t|
    t.string :username
    t.string :hashid
  end
end
