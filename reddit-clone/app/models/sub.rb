# == Schema Information
#
# Table name: subs
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  description  :string           not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord
    validates :description, :moderator_id, presence: true
    validates :title, uniqueness: true, presence: true
    
    belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User

    # has_many :post_subs
    has_many :post_subs, inverse_of: :post, dependent: :destroy

    has_many :posts,
    through: :post_subs,
    source: :post

end
