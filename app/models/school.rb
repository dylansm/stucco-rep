class School < ActiveRecord::Base
  has_many :users
  belongs_to :region
  has_and_belongs_to_many :programs

  validates(:name, presence: true)

  has_attached_file :school_logo, styles: { sm: "40x40#", :"sm@2x" => "80x80#", med: "60x60#", lg: "120x120#", :"lg@2x" => "240x240#" }
end
