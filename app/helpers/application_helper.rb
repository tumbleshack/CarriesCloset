module ApplicationHelper
    
    # Given a list of attributes (key, value), returns true if any are blank
    def any_blank?(att)
        att.any? { |k, v| v.blank? }
    end
end
