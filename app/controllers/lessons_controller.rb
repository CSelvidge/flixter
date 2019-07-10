class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]


  def show
  end

  private

  def require_authorized_for_current_lesson
    if current_lesson.section.course.user.enrolled_in?(@course) == false
      redirect_to courses_path(@course), alert: 'Unauthorized for content.'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
