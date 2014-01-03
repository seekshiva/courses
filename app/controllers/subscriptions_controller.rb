class SubscriptionsController < ApplicationController

  before_action :require_user, except: [:index]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    if @user.nil?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: { status: "Request cannot be processed", note: "User not logged in" } }
      end
    else
      @subscriptions = Subscription.where(:user_id => @user.id)

      subs = @subscriptions.collect do |sub|
        {
          id:           sub.id, 
          term_id:      sub.term_id,
          user_id:      @user.id,
          attending:    sub.attending,
          course_name:  sub.term.course.name,
          course_id:    sub.term.course_id,
          current:      sub.term.is_current?
        }
      end

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: subs }
      end
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    sub = Subscription.find(params[:id])

    ret = {
      id:           sub.id, 
      term_id:      sub.term_id,
      user_id:      sub.user_id,
      attending:    sub.attending,
      course_name:  sub.term.course.name,
      course_id:    sub.term.course_id,
      current:      sub.term.is_current?
    }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: ret }
    end
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    sub = Subscription.new(params[:subscription].except(:course_name, :course_id, :current))

    respond_to do |format|
      if sub.save
        ret = {
          id:           sub.id, 
          term_id:      sub.term_id,
          user_id:      sub.user_id,
          attending:    sub.attending,
          course_name:  sub.term.course.name,
          course_id:    sub.term.course_id,
          current:      sub.term.is_current?
        }
        format.html { redirect_to ret, notice: 'Subscription was successfully created.' }
        format.json { render json: ret, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: sub.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription].except(:created_at, :updated_at, :id, :course_name, :course_id, :current))
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end
end
