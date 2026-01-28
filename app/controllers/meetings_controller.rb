# class MeetingsController < ApplicationController
#   before_action :require_login
#   before_action :set_meeting, only: [:edit, :update, :destroy]

#   def index
#     @meetings = current_user.meetings.order(meeting_date: :asc, meeting_time: :asc)
#   end

#   def new
#     @meeting = Meeting.new
#   end

#   def create
#     emails = resolve_participants(params[:meeting][:participants])
#     @meeting = current_user.meetings.new(meeting_params)
#     @meeting.participants = emails

#     if @meeting.save
#       redirect_to meetings_path, notice: "Meeting scheduled successfully"
#     else
#       render :new
#     end
#   end

#   def edit
#   end

#   def update
#     if @meeting.update(meeting_params)
#       redirect_to meetings_path, notice: "Meeting updated successfully"
#     else
#       render :edit
#     end
#   end

#   def destroy
#     @meeting.destroy
#     redirect_to meetings_path, notice: "Meeting deleted successfully"
#   end

#   private

#   def set_meeting
#     @meeting = current_user.meetings.find(params[:id])
#   end

#   def meeting_params
#     params.require(:meeting).permit(:title, :meeting_date, :meeting_time, participants: [])
#   end

#   def resolve_participants(input)
#     input.split(",").map(&:strip).map do |value|
#       if value.match?(URI::MailTo::EMAIL_REGEXP)
#         value
#       else
#         contact = current_user.contacts.find_by("lower(name) = ?", value.downcase)
#         contact&.email
#       end
#     end.compact.uniq
#   end

# end

class MeetingsController < ApplicationController
  before_action :require_login
  before_action :set_meeting, only: [:edit, :update, :destroy]

  def index
    @meetings = current_user.meetings.order(meeting_date: :asc, meeting_time: :asc)
  end

  def new
    @meeting = Meeting.new
  end

  def create
    emails = resolve_participants(params[:meeting][:participants])

    if emails.nil?
      flash.now[:alert] = "Please enter valid contact name or email"
      @meeting = Meeting.new(meeting_params.except(:participants))
      render :new and return
    end

    @meeting = current_user.meetings.new(meeting_params.except(:participants))
    @meeting.participants = emails

    if @meeting.save
      redirect_to meetings_path, notice: "Meeting scheduled successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    emails = resolve_participants(params[:meeting][:participants])

    if emails.nil?
      flash.now[:alert] = "Please enter valid contact name or email"
      render :edit and return
    end

    if @meeting.update(meeting_params.except(:participants).merge(participants: emails))
      redirect_to meetings_path, notice: "Meeting updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @meeting.destroy
    redirect_to meetings_path, notice: "Meeting deleted successfully"
  end

  private

  def set_meeting
    @meeting = current_user.meetings.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :meeting_date, :meeting_time, participants: [])
  end

  # ⭐ CORE LOGIC
  def resolve_participants(inputs)
    emails = []

    inputs.each do |value|
      value = value.strip
      next if value.blank?

      if value.match?(URI::MailTo::EMAIL_REGEXP)
        emails << value
      else
        contact = current_user.contacts.find_by("lower(name) = ?", value.downcase)
        return nil unless contact
        emails << contact.email
      end
    end

    emails.uniq
  end
end
