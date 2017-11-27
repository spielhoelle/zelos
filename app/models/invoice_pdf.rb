require "render_anywhere"
require 'rqrcode'

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
                     :footer_font_name => "Oswald"
    #footer_html: "<h1>test</h1>"
    #:footer_left => footer_left
    #:footer_font_size => 30,
    #:footer_right => "Danke",
                    )
    kit.to_file("#{Rails.root}/public/invoice.pdf")
  end


  private

  attr_reader :invoice

  def as_html
    # for the PDF not for the preview
    total = invoice.items.collect{|i| i.price * i.count}.map{|i| i.to_s.to_f.round(2)}.inject(0, :+)
    qrcode = RQRCode::QRCode.new("bank://singlepaymentsepa?name=#{URI.escape( Setting['name'] )}&reason=Rechnung#{invoice.invoice_number}&iban=#{Setting['iban'].gsub(/\s+/, "")}&bic=#{Setting['bic'].gsub(/\s+/, "")}&amount=#{total.to_f}")

    qrcode = qrcode.as_svg(offset: 0, color: '000', shape_rendering: 'crispEdges', module_size: 2)

    render template: "admin/entries/pdf", layout: "invoice_pdf", locals: { invoice: invoice, total: total, qrcode: qrcode }
  end
end
