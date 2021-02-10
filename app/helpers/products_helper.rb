module ProductsHelper
  def format_name(name)
    name.split.map(&:capitalize).join(' ')
  end
end
