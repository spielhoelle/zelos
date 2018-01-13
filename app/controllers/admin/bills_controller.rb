module Admin
  class BillsController < ApplicationController

    before_action :authenticate_user!

    def index
      @bills = Bill.all.order("bill_date desc").group_by { |b| b.bill_date.beginning_of_year }

    end

    def new
      @bill = Bill.new
      render 'edit'
    end

    def edit
      @bill = Bill.find(params[:id])
      @title = "edit #{@bill.title} | Zelos"
    end
    
    def create
      @bill = Bill.create(bill_params)
      if @bill.save
        flash.now[:notice]=t('bill_created') 
        @entries = Bill.all
        redirect_to edit_admin_bill_path(@bill)
      end
    end

    def update
      @bill = Bill.find(params[:id])
      
      if @bill.update_attributes(bill_params)
        flash[:notice]=t('bill_updated') 
      else
        flash[:error] = @bill.errors.full_messages.first.to_s
      end

      redirect_to edit_admin_bill_path(@bill)
    end

    def destroy
      @bill = Bill.find(params[:id])
      @bill.destroy

      flash[:notice]=t('bill_destroyed') 
      redirect_to action: :index
    end

    def bill_params
      params.require(:bill)
        .permit(:title, :price, :bill_date, :image )
    end

  end
end
