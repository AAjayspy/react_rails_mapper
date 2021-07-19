class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :teaming_stage
      t.integer :appears_day
      t.integer :frequency
      t.string :type
      t.references :role, null: false, foreign_key: true
      t.boolean :is_required
      t.string :conditions
      t.references :mapping, null: false, foreign_key: true

      t.timestamps default: -> { 'NOW()' }
    end
  end
end
