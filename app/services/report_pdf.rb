require "prawn"

class ReportPdf
  COLUMN_WIDTH = 24

  def self.generate(title:, headers:, rows:)
    new(title:, headers:, rows:).render
  end

  def initialize(title:, headers:, rows:)
    @title = title
    @headers = headers
    @rows = rows
  end

  def render
    pdf = Prawn::Document.new(page_size: "A4", margin: 36)
    pdf.fill_color "111827"
    pdf.text @title, size: 18, style: :bold
    pdf.move_down 4
    pdf.fill_color "6B7280"
    pdf.text "Gerado em #{Time.zone.now.strftime('%d/%m/%Y %H:%M')}", size: 9
    pdf.move_down 16

    pdf.font("Courier") do
      pdf.fill_color "111827"
      pdf.text format_row(@headers), size: 8, style: :bold
      pdf.stroke_horizontal_rule
      pdf.move_down 8

      if @rows.any?
        @rows.each do |row|
          pdf.start_new_page if pdf.cursor < 48
          pdf.text format_row(row), size: 8
          pdf.move_down 5
        end
      else
        pdf.text "Nenhum registro encontrado.", size: 9
      end
    end

    pdf.render
  end

  private

    def format_row(row)
      row.map { |value| normalize(value).ljust(COLUMN_WIDTH)[0, COLUMN_WIDTH] }.join
    end

    def normalize(value)
      value.to_s.squish
    end
end
