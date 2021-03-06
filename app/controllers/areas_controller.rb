# -*- coding: utf-8 -*-
class AreasController < ApplicationController
  load_and_authorize_resource
  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @areas }
      #format.pdf do
      #  pdf = AreasPdf.new(@areas, view_context)
      #  send_data pdf.render, filename: "areas.pdf",
      #                        type: "application/pdf",
      #                        disposition: "inline"
      #end
      format.pdf {reporte_areas(@areas)}
      format.xls {send_data @areas.to_xls, :filename => 'reporte.xls' }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    @area = Area.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: 'Area se ha creado con éxito.' }
        format.json { render json: @area, status: :created, location: @area }
      else
        format.html { render action: "new" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to @area, notice: 'Area se ha actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = Area.find(params[:id])
    if @area.destroy
      message = "Área eliminada correctamente"
    else
      message = "Área No eliminada, contiene dependencias"
    end

    respond_to do |format|
      format.html { redirect_to areas_url, :notice => message }
      format.json { head :no_content }
    end       
  end
  
  def reporte_areas(areas)
    report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'areas.tlf')
    
    areas.each do |area|
      report.list.add_row do |row|        
        row.values clave: area.clave, 
                   descripcion: area.descripcion,                    
                   correo_electronico: area.correo_electronico,
                   responsable: area.responsable
                
        row.item(:clave).style(:color, 'red')
      end 
    end
    
    send_data report.generate, filename: 'areas.pdf', 
                               type: 'application/pdf', 
                               disposition: 'attachment'
  end
end
