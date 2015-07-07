require_dependency "rhinoart/application_controller"

module Rhinoart
	class HelpsController < ApplicationController
		def index
			begin
				# send_file Rails.configuration.help_file_path, :filename => 'Help', type: 'application/pdf', disposition: params[:disposition] ||= 'inline'
				send_data IO.binread(Rails.configuration.help_file_path), :filename => 'Help', type: 'application/pdf', disposition: params[:disposition] ||= 'inline'
			rescue Exception => e
				flash.now[:warning] = 'File not found'
			end
		end
	end
end
