# Automatically include the executable and command name in the syntax statment
class Commander::Command
  def syntax=(syntax)
    @syntax = "#{EC2Manage.name} #{@name} #{syntax}"
  end
end
