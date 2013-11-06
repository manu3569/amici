Sequel.migration do
  change do
    create_table :setups do
      primary_key :id
      String      :owner_name
      String      :client_id
      String      :client_secret
    end
  end
end