module Admin
  class SummariesController < ApplicationController
    before_action :authenticate_user!

    def index
      @entries = Entry.visible.group_by { |u| u.delivery_date.beginning_of_year }
      @bills = Bill.all.group_by { |u| u.bill_date.beginning_of_year }
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
