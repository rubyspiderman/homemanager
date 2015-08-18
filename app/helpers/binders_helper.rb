module BindersHelper
  
  def binder_from_property(property)
    @binder = Binder.find(property.binder_id)
  end
  
  def binder_from_property_id(id)
    @property = Property.find(id)
    @binder = Binder.find(@property.binder_id)
  end
  
  def binder_from_structure(structure)
    @property = Property.find(structure.property_id)
    @binder = Binder.find(@property.binder_id)
  end
  
end
