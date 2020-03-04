module SalesHelper 
  def active_sale?
    Sale.active.any?
  end

  def current_sales
    @current_sales = Sale.active.first
  end
end
