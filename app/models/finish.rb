class Finish < ActiveRecord::Base
  # attr_accessible :title, :body
  resourcify
  
  belongs_to :binder

  has_one :purchase, :as => :purchaseable
  has_many :shares, :as => :sharable
  has_many :notes, :as => :notable
  has_many :tags, :as => :taggable, :dependent => :destroy
  
  validates_presence_of :name, :message => I18n.t(:value_required)
  validates_length_of :name, :maximum => 50
  validates_length_of :make, :maximum => 50
  validates_length_of :model, :maximum => 50
  validates_length_of :details, :maximum => 500
  
  accepts_nested_attributes_for :purchase
  
  after_create :add_new_typeahead_options
  
  def add_new_typeahead_options
    FinishMake.where(:name => self.make.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.make.nil?
    FinishModel.where(:name => self.model.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.model.nil?
  end
  
  def structures
    return TagManager.find_tagged_resources(self.tags)[:structures]
  end
  
  def areas
    return TagManager.find_tagged_resources(self.tags)[:areas]
  end
  
end
