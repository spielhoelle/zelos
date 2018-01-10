module Admin
  class SummariesController < ApplicationController
    include SummariesHelper
    before_action :authenticate_user!

    def index

      ordered_summaries = Summary.order("delivery_date desc")
      unless params[:search].blank?
        ordered_summaries = ordered_summaries.where(:title => params[:search])
      end
      @summaries = ordered_summaries.group_by { |u| u.delivery_date.beginning_of_year }

      @this_year =  Summary.visible.where("delivery_date >= ?", Time.zone.now.beginning_of_year)
      @title = "#{@this_year.collect { |x| get_items_total(x)}.reduce(0, :+).to_s.to_f.round(0)} € this year"
      @chart_lastyear = @this_year.where("customer_id IS NOT NULL").collect{ |e| [e.customer.company, e.items.map{|i| (i.price * i.count).to_s.to_f.round(2)}.inject(0, :+)] }.sort {|a,b| a[1] <=> b[1]}.reverse
      @data = @this_year.where("customer_id IS NOT NULL").order("delivery_date desc").map do |value|
        {name: value.customer.name, 
         data: value.items.map do |i| 
          [value.customer.name, value.items.map{|v| (v.price * v.count/60).to_s.to_f.round(2)}.inject(0, :+)]
        end
        }
      end
      @data2 = Customer.all.collect do |value|
        { name: value.name, data: value.summaries.collect{|summary| [value.name, summary.items.collect{|i| (i.price * i.count).to_s.to_f.round(2)}.reduce(0, :+)]  }.sort {|a,b| a[1] <=> b[1]}.reverse}
      end
      respond_to do |format|
        format.html {
          if ordered_summaries.length == 1 && params[:search].present?
            redirect_to edit_admin_summary_path(ordered_summaries.first)
          end

        }
        format.json {render json: ordered_summaries}
      end
    end

    def new
      @summary = Summary.new
      @items = @summary.items.build
      @customer = @summary.customer || Customer.new
      render 'edit'
    end

    def edit
      @summary = Summary.find(params[:id])
      @item = Item.new
      @customer = @summary.customer || Customer.new
      @title = "edit #{@summary.title} | Zelos"
      @time = "#{ @summary.items.collect{|x| x.count}.reduce(0, :+) / 60 }:#{@summary.items.collect{|x| x.count}.reduce(0, :+) % 60} H"
    end

    def clone
      summary = Summary.find(params[:id])
      @summary = summary.dup
      @summary.invoice_number = Time.now.to_i
      @summary.title = "#{summary.title} Duplicate"
      @summary.save
      summary.items.each do |item|
        @summary.items.create(item.dup.attributes)
      end
      @item = Item.new
      flash.now[:notice] = 'Summary cloned!'
      redirect_to edit_admin_summary_path(@summary)
    end

    def show
      redirect_to action: "edit"
    end

    def update
      @summary = Summary.find(params[:id])
      if summary_params["customer_attributes"]["id"].present?
        @customer = Customer.find(summary_params["customer_attributes"]["id"])
        @summary.customer = @customer
      end

      if @summary.update_attributes(summary_params)
        flash[:notice] = 'Summary has been saved successfully!'
      else
        flash[:error] = @summary.errors.full_messages.first.to_s
      end

      redirect_to edit_admin_summary_path(@summary)
    end

    def create
      @summary = Summary.new
      if @summary.save
        if summary_params["customer_attributes"]["id"].present?
          @customer = Customer.find(summary_params["customer_attributes"]["id"])
          @summary.customer = @customer
        end
        @summary.update_attributes(summary_params)
        flash.now[:success] = 'Summary has been created successfully!'
        @summaries = Summary.all
        redirect_to edit_admin_summary_path(@summary)
      else
        flash.now[:error] = 'There was a problem :('
      end
    end

    def destroy
      @summary = Summary.find(params[:id])
      @summary.items.destroy_all
      if @summary.destroy
        flash[:notice] = 'Summary destroyed!'
      else
        flash[:error] = 'There was a problem :('
      end
      @summaries = Summary.all

      redirect_to action: :index
    end

    private

    def summary_params
      params.require(:summary)
        .permit(:title, :invoice_number, :invoice_date, :delivery_date, :notes, :private_note, :discount, :company, :is_offer, :is_consultant, :valid_until, :status, customer_attributes: [:id, :name, :address, :company],  items_attributes: [:name, :price, :count_hours, :count_mins, :_destroy, :id])
    end
  end
end
