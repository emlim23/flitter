class UploadController < ApplicationController
	def uploadFile
		require 'fileutils'
		tmp = params[:file_upload][:avatar].tempfile
		file = File.join("public", params[:file_upload][:avatar].original_filename)

		# FileUtils.cp tmp.path, file
		# # your parsing job
		# FileUtils.rm file
		File.open(file, "wb") { |f| f.write(params[:file_upload][:avatar].read) }
	end
end
