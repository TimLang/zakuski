class CustomSearchEngine
  include Mongoid::Document
  include Mongoid::Timestamps

  field :access, type: String, default: 'public'
  field :current_links, type: Integer, default: 1
  field :history_links, type: Integer, default: 1
  
  # custom search engine specification
  embeds_one :specification
  
  # custom search engine annotations
  embeds_many :annotations

  embeds_many :votes

  has_many :replies

  belongs_to :user
  belongs_to :linking_custom_search_engine
  belongs_to :real_node

  # Index
  index({user_id: 1}, {name: 'cse_user_id'})
  index({real_node_id: 1}, {name: 'cse_real_node_id'})

  accepts_nested_attributes_for :annotations, allow_destroy: true
  accepts_nested_attributes_for :specification

  attr_accessible :access, :specification_attributes, :annotations_attributes, :real_node_id

  # validations
  validates :access, presence: true, inclusion: {in: ['public', 'protected', 'private']}
  validates :user_id, presence: true
  validates :real_node_id, presence: true
  
end
