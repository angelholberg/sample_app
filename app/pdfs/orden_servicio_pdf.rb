# -*- coding: utf-8 -*-
class OrdenServicioPdf < Prawn::Document
  def initialize(orden_servicio, view)
    super(top_margin: 70)
    @orden_servicio = orden_servicio
    @view = view
    
    orden_servicio_reporte
  end
  
  def orden_servicio_reporte
    text "Orden de Servicio", size: 14, style: :bold, align: :center   
    text "Id\: #{@orden_servicio.id}", size: 14, style: :bold
    text "Folio\: #{@orden_servicio.folio}", size: 14, style: :bold
    text "Fecha recepcion\: #{@orden_servicio.fecha_recepcion}", size: 14, style: :bold
    text "Fecha entrega\: #{@orden_servicio.fecha_entrega}", size: 14, style: :bold    
    text "Activo\: #{@orden_servicio.activo.descripcion}", size: 14, style: :bold
    text "Series\: #{@orden_servicio.series.nombre}", size: 14, style: :bold               
    text "Código de barras:", size: 14, style: :bold
    doc=RGhost::Document.new
    doc.barcode_ean13("#{@orden_servicio.activo.codigo}",:columns => 2, :rows=> 2, :text => {:size => 10})
    doc.render :jpeg, :filename => "#{Rails.root}/app/assets/images/barcodes/barcode.jpeg"                          
    image "#{Rails.root}/app/assets/images/barcodes/barcode.jpeg" , :at => [50,570], :width => 500
    text ""
    text ""
    text ""
    text "Imagen:", size: 14, style: :bold
    if @orden_servicio.activo.imagen_url?
      if File.exist?("#{@orden_servicio.activo.imagen_url}")
        image "#{@orden_servicio.activo.imagen_url}" , :at => [50,570], :width => 50
      else
        text "No existe la imagen"
      end
    end                                      
    
    fallas   
    reparaciones
  end  
  
  def fallas_rows  
    text "Fallas", size: 14, style: :bold, align: :center           
    [["Descripcion"]] +  
    @orden_servicio.falla.map do |item|
      [item.descripcion]
    end     
  end   
  
  def fallas
    move_down 20  
    position = :center
    table fallas_rows do      
      row(0).font_style = :bold
      columns(1..1).align = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true     
    end     
  end   
  
  def reparaciones_rows  
    text "Reparaciones", size: 14, style: :bold, align: :center           
    [["Descripcion"]] +  
    @orden_servicio.reparacion.map do |item|
      [item.descripcion]
    end     
  end   
  
  def reparaciones
    move_down 20
    table reparaciones_rows do
      row(0).font_style = :bold
      columns(1..1).align = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true     
    end     
  end     
end
