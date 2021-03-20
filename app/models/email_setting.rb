class EmailSetting < ApplicationRecord
  OPTIONS = {
    '': 0,
    'None': 1,
    'All Urgent Requests': 2,
    'All Incoming Requests': 3
  }.freeze
  
  belongs_to :user
end
