class UserPolicy < BasePolicy

	def method_missing(m, *args, &block)
		Current.user.admin?
	end

end