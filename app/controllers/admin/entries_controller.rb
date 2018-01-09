module Admin
  class EntriesController < ApplicationController
    include EntriesHelper
    before_action :authenticate_user!

    def index

      ordered_entries = Entry.order("delivery_date desc")
      unless params[:search].blank?
        ordered_entries = ordered_entries.where(:title => params[:search])
      end
      @entries = ordered_entries.group_by { |u| u.delivery_date.beginning_of_year }

      @this_year =  Entry.visible.where("delivery_date >= ?", Time.zone.now.beginning_of_year)
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
        { name: value.name, data: value.entries.collect{|entry| [value.name, entry.items.collect{|i| (i.price * i.count).to_s.to_f.round(2)}.reduce(0, :+)]  }.sort {|a,b| a[1] <=> b[1]}.reverse}
      end
      respond_to do |format|
        format.html {
          if ordered_entries.length == 1 && params[:search].present?
            redirect_to edit_admin_entry_path(ordered_entries.first)
          end

        }
        format.json {render json: ordered_entries}
      end
    end

    def new
      @entry = Entry.new
      @items = @entry.items.build
      @customer = @entry.customer || Customer.new
      render 'edit'
    end

    def edit
      @entry = Entry.find(params[:id])
      @item = Item.new
      @customer = @entry.customer || Customer.new
      @title = "edit #{@entry.title} | Zelos"
      @time = "#{ @entry.items.collect{|x| x.count}.reduce(0, :+) / 60 }:#{@entry.items.collect{|x| x.count}.reduce(0, :+) % 60} H"
    end

    def clone
      entry = Entry.find(params[:id])
      @entry = entry.dup
      @entry.invoice_number = Time.now.to_i
      @entry.title = "#{entry.title} Duplicate"
      @entry.save
      entry.items.each do |item|
        @entry.items.create(item.dup.attributes)
      end
      @item = Item.new
      flash.now[:notice] = 'Entry cloned!'
      redirect_to edit_admin_entry_path(@entry)
    end

    def show
      redirect_to action: "edit"
    end

    def update
      @entry = Entry.find(params[:id])
      if entry_params["customer_attributes"]["id"].present?
        @customer = Customer.find(entry_params["customer_attributes"]["id"])
        @entry.customer = @customer
      end

      if @entry.update_attributes(entry_params)
        flash[:notice] = 'Entry has been saved successfully!'
      else
        flash[:error] = @entry.errors.full_messages.first.to_s
      end

      redirect_to edit_admin_entry_path(@entry)
    end

    def create
      @entry = Entry.new
      if @entry.save
        if entry_params["customer_attributes"]["id"].present?
          @customer = Customer.find(entry_params["customer_attributes"]["id"])
          @entry.customer = @customer
        end
        @entry.update_attributes(entry_params)
        flash.now[:success] = 'Entry has been created successfully!'
        @entries = Entry.all
        redirect_to edit_admin_entry_path(@entry)
      else
        flash.now[:error] = 'There was a problem :('
      end
    end

    def destroy
      @entry = Entry.find(params[:id])
      @entry.items.destroy_all
      if @entry.destroy
        flash[:notice] = 'Entry destroyed!'
      else
        flash[:error] = 'There was a problem :('
      end
      @entries = Entry.all

      redirect_to action: :index
    end

    private

    def entry_params
      params.require(:entry)
        .permit(:title, :invoice_number, :invoice_date, :delivery_date, :notes, :private_note, :discount, :company, :is_offer, :is_consultant, :valid_until, :status, customer_attributes: [:id, :name, :address, :company],  items_attributes: [:name, :price, :count_hours, :count_mins, :_destroy, :id])
    end
  end
end
