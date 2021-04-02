class EmailSetting < ApplicationRecord
  OPTIONS = {
    'All Urgent Requests': 1,
    'All Incoming Requests': 2,
    'None': 3
  }.freeze

  DEFAULT = OPTIONS.key(1)

  belongs_to :user

  # If user has not set an email preference, EmailPreferences for a user will
  # default to send only urgent requests.
  def send_urgent?; preference == EmailSetting::OPTIONS[:'All Urgent Requests'] || preference.nil?; end
  def send_all?; preference == EmailSetting::OPTIONS[:'All Incoming Requests']; end
  def send_none?; preference == EmailSetting::OPTIONS[:'None']; end

end
