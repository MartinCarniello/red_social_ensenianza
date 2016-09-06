class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @search = UserSearch.new(search_params)
    @users  = @search.results.with_role(:teacher)
  end

  def show
    @user = User.find(params[:id])
    @teacher = TeacherProfile.find(params[:id])
    @experience = TeacherExperience.find(@teacher.id)
  end

  def search_params
    @search_params ||= params.delete(:user_search) || {}
  end
end
