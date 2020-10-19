class Menu < ApplicationRecord
  belongs_to :user

  validates :recommend_title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 255 }

  #TODO: 複数条件の指定、order以外を指定する場合などに問題が発生する可能性ある
  default_scope -> { order(created_at: :desc) }
end
