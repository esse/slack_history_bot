class Message < ActiveRecord::Base
  
  searchable do
    text :message
    string :user_name do |field|
      Dictionary.where(:uid => field).first.try(:value)
    end 
    string :channel_h do |field| 
      Dictionary.where(:uid => field).first.try(:value)
    end
    string :user
    string :channel
  end
  
  def user_name
   Dictionary.where(:uid => user).first.try(:value) || user
   end
   
  def channel_h
    Dictionary.where(:uid => channel).first.try(:value) || channel
  end
end
