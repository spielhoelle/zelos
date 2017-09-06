require "render_anywhere"

class InvoicePdf
  include RenderAnywhere

  def initialize(invoice)
    @invoice = invoice
  end

  def to_pdf
    #footer_left = invoice.is_offer? ? "Sollten Sie Fragen zu diesem Angebot haben, zögern Sie nicht, mich zu kontaktieren. \nVielen Dank für Interesse!" : "Bitte überweisen Sie den Betrag an:\n" + Setting["name"] + "\n" + Setting["iban"].gsub(/\s+/, "") + "\n" + Setting["bic"]
    kit = PDFKit.new(as_html,
      page_size: 'A4',
      footer_line: false,
      #footer_html: "<h1>test</h1>"
       :footer_font_name => "Oswald"
       #:footer_left => footer_left
       #:footer_font_size => 30,
       #:footer_right => "Danke",
      )
    kit.to_file("#{Rails.root}/public/invoice.pdf")
  end

  def filename
    "Invoice #{invoice.id}.pdf"
  end

  private

    attr_reader :invoice

    def as_html
      total = invoice.items.collect{|i| i.price * i.count}.map{|i| i.to_s.to_f.round(2)}.inject(0, :+)
      render template: "admin/entries/pdf", layout: "invoice_pdf", locals: { invoice: invoice, total: total }
    end
end
