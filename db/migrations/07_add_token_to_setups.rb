Sequel.migration do
  change do
    add_column :setups, :token, String
  end
end