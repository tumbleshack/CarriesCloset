module PublicHelper
  def link_to_email(email_str)
    link_to email_str, "mailto:#{email_str}"
  end
end
