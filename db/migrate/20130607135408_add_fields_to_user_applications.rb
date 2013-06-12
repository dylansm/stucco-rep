class AddFieldsToUserApplications < ActiveRecord::Migration
  def change
    add_column :user_applications, :user_id, :integer
    add_column :user_applications, :mobile_phone, :string
    add_column :user_applications, :gender, :string, :limit => 1
    add_column :user_applications, :bio, :text
    add_column :user_applications, :street_address, :string
    add_column :user_applications, :street_address2, :string
    add_column :user_applications, :city, :string
    add_column :user_applications, :state, :string
    add_column :user_applications, :postal_code, :string
    add_column :user_applications, :country, :string
    add_column :user_applications, :planned_grad_year, :string
    add_column :user_applications, :planned_grad_term, :string
    add_column :user_applications, :major, :string
    add_column :user_applications, :minor, :string
    add_column :user_applications, :gpa, :float
    add_column :user_applications, :num_facebook_friends, :integer
    add_column :user_applications, :num_instagram_followers, :integer
    add_column :user_applications, :num_twitter_followers, :integer
    add_column :user_applications, :other_social_sites, :string
    add_column :user_applications, :member_design_community, :string
    add_column :user_applications, :portfolio_url, :string
    add_column :user_applications, :behance_profile_url, :string
    add_column :user_applications, :extracurriculars, :text
    add_column :user_applications, :extracurricular_leadership, :boolean
    add_column :user_applications, :leadership_description, :text
    add_column :user_applications, :reference_name, :string
    add_column :user_applications, :reference_relationship, :string
    add_column :user_applications, :reference_email, :string
    add_column :user_applications, :reference_phone, :string
    add_column :user_applications, :how_adobe_helps, :text
    add_column :user_applications, :student_orgs_and_leverage, :text
    add_column :user_applications, :teaching_experience, :text
    add_column :user_applications, :what_sets_you_apart, :text
    add_column :user_applications, :do_you_have_time, :string, :limit => 1
    add_column :user_applications, :available_to_work, :string, :limit => 1
    add_column :user_applications, :video_submission_url, :string
    add_attachment :user_applications, :resume
    add_index :user_applications, :user_id
  end
end
