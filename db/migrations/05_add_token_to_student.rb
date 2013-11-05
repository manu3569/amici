Sequel.migration do
  change do
    add_column :students, :token, String
  end
end