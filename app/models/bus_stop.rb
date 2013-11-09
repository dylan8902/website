class BusStop < ActiveRecord::Base

  #http://www.dft.gov.uk/NaPTAN/snapshot/NaPTANcsv.zip

  def to_s
    name = self.common_name + ", " + self.locality_name
    name += ", " + self.parent_locality_name if self.parent_locality_name
    return name
  end

end