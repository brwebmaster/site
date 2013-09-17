class CreateInterestEmails < ActiveRecord::Migration
  def change
    create_table :interest_emails do |t|
      t.string :email

      t.timestamps
    end
  end
end
