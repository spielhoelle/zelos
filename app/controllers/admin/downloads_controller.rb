module Admin
  class DownloadsController < ApplicationController
    before_action :authenticate_user!
    def show
      I18n.locale = Setting.language
      respond_to do |format|
        @invoice = Entry.find(params[:entry_id])
        @total = @invoice.items.collect{|i| i.price * i.count}.map{|i| i.to_s.to_f.round(2)}.inject(0, :+)
        @title = "#{@invoice.delivery_date.strftime("%Y%m%d")}_#{@invoice.title.gsub(" ", "_")}.pdf"
        @request = 'html'
        format.html {
          render :template => "admin/entries/pdf", :locals => {         
            invoice: @invoice,
            total: @total,
            req_type: @request
          }
        }
        format.pdf {
          @request = 'pdf'
          send_invoice_pdf
         }
      end
    end

        private

    def invoice_pdf
      InvoicePdf.new(@invoice)
    end

    def send_invoice_pdf
      @title = "#{@invoice.delivery_date.strftime("%Y%m%d")}_#{@invoice.title.gsub(" ", "_")}.pdf"
      send_file invoice_pdf.to_pdf,
        filename: @title,
        type: "application/pdf",
        disposition: "inline"
    end
  end
end
