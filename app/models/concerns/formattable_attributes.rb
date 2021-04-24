module FormattableAttributes
  def meet
    said_no = read_attribute(:meet) == 2
    county_as_other = county == 8
    address_set = !address.nil?

    said_no || county_as_other || address_set ?  "No" : "Yes"
  end
end
