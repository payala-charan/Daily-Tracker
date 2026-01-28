class UploadedFilesController < ApplicationController
  before_action :set_file, only: %i[edit update destroy]

  def index
    @files = current_user.uploaded_files
  end

  def new
    @file = current_user.uploaded_files.new
  end

  def create
    @file = current_user.uploaded_files.new(file_params)

    if @file.save
      redirect_to uploaded_files_path, notice: "File uploaded successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @file.update(file_params)
      redirect_to uploaded_files_path, notice: "File updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @file.destroy
    redirect_to uploaded_files_path, notice: "File deleted successfully"
  end

  private

  def set_file
    @file = current_user.uploaded_files.find(params[:id])
  end

  def file_params
    params.require(:uploaded_file).permit(:file, :title)
  end
end
