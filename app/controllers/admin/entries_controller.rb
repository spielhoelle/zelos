require 'net/http'
module Admin
  class EntriesController < ApplicationController
    include EntriesHelper
    before_action :authenticate_user!

    def index
      @ordered_entries = Entry.order("delivery_date desc")

      unless params[:search].blank?
        @ordered_entries = @ordered_entries.where('title LIKE ?', "%#{params[:search]}%")
      end
      unless params[:year].blank?
        @ordered_entries = @ordered_entries.where('extract(year  from delivery_date) = ?', params[:year])
        @this_year =  @ordered_entries
      else 
        @this_year =  @ordered_entries.where("delivery_date >= ?", Time.zone.now.beginning_of_year)
      end
      @entries = @ordered_entries.group_by { |u| u.delivery_date.beginning_of_year }

      if params[:year].blank? && params[:search].blank?
        @title = "#{@this_year.collect { |x| get_items_total(x)}.reduce(0, :+).to_s.to_f.round(0)} € this year"
      else 
        @title = "#{@ordered_entries.collect { |x| get_items_total(x)}.reduce(0, :+).to_s.to_f.round(0)} €"
      end

      @chart_lastyear = @this_year.where("customer_id IS NOT NULL").collect{ |e| [e.customer.company, e.items.map{|i| (i.price * i.count/60).to_s.to_f.round(2)}.inject(0, :+)] }.sort {|a,b| a[1] <=> b[1]}.reverse
      @data = @this_year.where("customer_id IS NOT NULL").order("delivery_date desc").map do |value|
        {name: value.customer.name,
         data: value.items.map do |i|
          [value.customer.name, value.items.map{|v| (v.price * v.count/60).to_s.to_f.round(2)}.inject(0, :+)]
        end
        }
      end

      @data2 = []
      Customer.all.map do |customer|
        ctotal = []
        customer.entries.visible.map do |entry|
          ctotal << [customer.name, get_items_total(entry)]
        end
        # ctotal.unshift(customer.name)
        entry = {
          name: customer.name,
          data: ctotal
        }
        @data2 << entry
        @data2 = @data2
      end
      respond_to do |format|
        format.html {
          if @ordered_entries.length == 1 && params[:search].present?
            redirect_to edit_admin_entry_path(@ordered_entries.first)
          end

        }
        format.json {render json: @ordered_entries}
      end
    end

    def new
      @entry = Entry.new
      @items = @entry.items.build
      @title = "#{params[:is_offer] ? "New offer" : "New invoice"} | Zelos"
      @customer = @entry.customer || Customer.new
      render 'edit'
    end

    def edit
      @entry = Entry.find(params[:id])
      puts "notes"
      puts @entry.inspect
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
        if entry_params["sum_time"] == "0"
          @entry.update_attribute(:delivery_date, entry_params["invoice_date"])
        end
        flash[:success] = 'Entry has been saved successfully!'
      else
        flash[:error] = @entry.errors.full_messages.first.to_s
      end
      @entry.items.each do |item, index|
        orderdindex = 0
        entry_params["items_attributes"].each do |subitem, subindex|
          if subindex["id"].to_i == item.id
            puts "######"
            puts item.inspect
            puts  subitem
            puts  subindex.inspect
            orderdindex = subitem
          end
        end
        @entry.items[index.to_i].sort = orderdindex
      end
      puts @entry.items.inspect
      puts "######"
      @entry.save
      puts @entry.items.inspect

      redirect_to edit_admin_entry_path(@entry, :updated => "true")
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

    def import
      @current_page = 1
      @entry = Entry.find(params[:id])
      wsid = Rails.application.secrets.toggle_workspace_id
      api_token = Rails.application.secrets.toggle_api_token

      uri = URI("https://api.track.toggl.com/reports/api/v2/details?workspace_id=#{wsid}&since=#{@entry.invoice_date.at_beginning_of_month.strftime("%Y-%m-%d")}&until=#{@entry.invoice_date.strftime("%Y-%m-%d")}&user_agent=api_example_test&page=#{@current_page}")

      req = Net::HTTP::Get.new(uri)
      req.basic_auth api_token, 'api_token'

      http = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true)
      resp = http.request(req)
      response = JSON.parse(resp.body)
      @entry_items = response["data"]
      if response["per_page"] < response["total_count"] 
        items_fetched = response["per_page"]
        while items_fetched < response["total_count"]
          items_fetched = items_fetched + response["per_page"]
          @current_page = @current_page + 1

          uri = URI("https://api.track.toggl.com/reports/api/v2/details?workspace_id=#{wsid}&since=#{@entry.invoice_date.at_beginning_of_month.strftime("%Y-%m-%d")}&until=#{@entry.invoice_date.strftime("%Y-%m-%d")}&user_agent=api_example_test&page=#{@current_page}")
          req = Net::HTTP::Get.new(uri)
          req.basic_auth api_token, 'api_token'
          http = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true)
          resp = http.request(req)
          response = JSON.parse(resp.body)
          
          @entry_items = @entry_items + response["data"]
        end
      end
      entry_items = @entry_items.select { |l| l["client"] == @entry.customer.company && l["dur"] > 0 }.sort { |a,b| a["end"] <=> b["end"] }
      current_price = @entry.items[0].price
      @entry.items.destroy_all
    
      entry_items.each do |item, index|
        duration_min = item["dur"] / 1000 / 60
        if duration_min != 0 
          @entry.items.create!(
            count: duration_min, 
            name: item["description"] != "" ? item["description"] : "No description",
            price: current_price,
            item_date: item["end"],
            sort: index)
        end
      end
      redirect_to edit_admin_entry_path(@entry)
    end
    private

    def entry_params
      params.require(:entry)
        .permit(:title, :invoice_number, :invoice_date, :delivery_date, :notes, :private_note, :discount, :company, :is_offer, :cash, :is_consultant, :valid_until, :status, :sum_time, customer_attributes: [:id, :name, :address, :company],  items_attributes: [:name, :price, :count_hours, :count_mins, :_destroy, :id, :item_date, :expense])
    end
  end
end
