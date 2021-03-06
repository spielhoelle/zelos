module Admin
  class CustomersController < ApplicationController
    include EntriesHelper

    before_action :authenticate_user!

    def index
      @customers = Customer.all.order('name asc')
      @grouped_customers = @customers.group_by{|x| x.name[0,1]}
      @customer_count = Customer.all.map{|e| e.entries.count}.max
      @title = "Customers"
      unless params[:search].blank?
        @customers = Customer.where(:name => params[:search]).order('name asc')
        @grouped_customers = @customers.group_by{|x| x.name[0,1]}
      end
      respond_to do |format|
        format.html {
          if @customers.length == 1 && params[:search].present?
            redirect_to edit_admin_customer_path(@customers.first)
          end
        }
        format.json {render json: @customers}
      end
    end

    def new
      @customer = Customer.new
      render 'edit'
    end

    def edit
      @customer = Customer.find(params[:id])
      @title = "edit #{@customer.name} | Zelos"
      @total_last_year = @customer.entries.visible.collect{ |x|  get_items_total(x)}.inject(0, :+)
    end
    
    def create
      @customer = Customer.create(customer_params)
      if @customer.save
        flash.now[:notice]=t('customer_created') 
        @entries = Customer.all
        redirect_to edit_admin_customer_path(@customer)
      end
    end

    def update
      @customer = Customer.find(params[:id])
      
      if @customer.update_attributes(customer_params)
        flash[:notice]=t('customer_updated') 
      else
        flash[:error] = @customer.errors.full_messages.first.to_s
      end

      redirect_to edit_admin_customer_path(@customer)
    end

    def destroy
      @customer = Customer.find(params[:id])
      @customer.destroy

      flash[:notice]=t('customer_destroyed') 
      redirect_to action: :index
    end

    def customer_params
      params.require(:customer)
        .permit(:name, :address, :company )
    end

  end
end
