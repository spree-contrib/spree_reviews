class AddIpAddressToReviews < SpreeExtension::Migration[4.2]
  def self.up
    add_column :reviews, :ip_address, :string
  end

  def self.down
    remove_column :reviews, :ip_address
  end
end
