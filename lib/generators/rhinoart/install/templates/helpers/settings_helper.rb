module SettingsHelper
	def setting_by_name(name, reload = false)
		if !reload && session[:"setting_#{name}"].present?
			session[:"setting_#{name}"]
		else
			setting = Rhinoart::Setting.find_by_name(name)
			session[:"setting_#{name}"] = setting.value if setting.present?
		end
	end
end