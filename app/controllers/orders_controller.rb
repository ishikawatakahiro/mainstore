class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
skip_before_filter :authorize,only:[:new,:create]
  # GET /orders
  # GET /orders.json
  

def index
	#@orders = Order.paginate :page => params[:page], :order => 'created_at desc', :per_page 10)
	#@orders = Order.paginate(page: params[:page], order: 'created_at desc', per_page: 10)
	@orders = Order.paginate(page: params[:page],per_page: 10).order('created_at DESC')

	session[:orders] = @orders
	@orders = session[:orders]
#render :action => 'index.html.erb'


	 respond_to do |format|
	format.html
	format.pdf { render_order_list(@orders) }
	format.json{render json: @orders}
  	end
end

  def confirm
	 if invalid?(sort(params[:orders]))
      render :action => 'index.html.erb'
      return
    end  
    
    session[:orders] = @orders;
    @departments = Department.find(:all)
    render :action => 'confirm.html.erb'
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
@cart=current_cart
if @cart.line_items.empty?
redirect_to store_url,notice:"カートは空です"
return
end

    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
@order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.save
Cart.destroy(session[:cart_id])
session[:cart_id]=nil

OrderNotifier.received(@order).deliver
OrderNotifier.seller(@order).deliver

        format.html { redirect_to store_url, notice: 'ご注文ありがとうございます。' }
        format.json { render :show, status: :created, location: @order }
      else
@cart=current_cart
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

    def store
	@orders=session[:orders]

 begin
      #トランザクション開始
      ActiveRecord::Base.transaction {
        for e in @orders
          next if e.update_check != "1"
          
          #更新します。補足："e"はEmployeeのオブジェクト
          Order.find(e.id).update_attributes(e.attributes)
        end
      }
    rescue => ex
      #例外発生時の処理を記述します。
      render :text => ex
      return
    ensure
      session[:orders] = nil
    end
    index
  end


  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update


    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :apointmentdate, :delivery)
    end

    def invalid?
   @orders = Array.new
    invalid = false;
    objects.each { |o|
      e = Order.new(o[1])
      e.id = o[1]["id"]
      #更新チェックされているものだけ検証
      if o[1]["update_check"] * "1"
        if !e.valid?
          invalid = true
        end
      end
      @orders.push(e)
    }
    return invalid
  end


   def render_order_list(orders)
      report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'index.tlf')

      orders.each do |order|
        report.list.add_row do |row|
          row.values name: order.name, 
                     address: order.address, 
                     email: order.email, 
                     pay_type: order.pay_type
          row.item(:name).style(:color, 'red') 
        end
      end
      
      send_data report.generate, filename: 'orders.pdf', 
                                 type: 'application/pdf', 
                                 disposition: 'attachment'
    end

end
