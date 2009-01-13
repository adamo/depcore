class Portfolios < Application
  # provides :xml, :yaml, :js
  before :ensure_authenticated,:exclude => [:index]
  
  def index
    @portfolios = Portfolio.all
    display @portfolios
  end

  def show(id)
    @portfolio = Portfolio.get(id)
    raise NotFound unless @portfolio
    display @portfolio
  end

  def new
    only_provides :html
    @portfolio = Portfolio.new
    display @portfolio
  end

  def edit(id)
    only_provides :html
    @portfolio = Portfolio.get(id)
    raise NotFound unless @portfolio
    display @portfolio
  rescue NotFound
    redirect resource :portfolios
  end

  def create(portfolio)
    @portfolio = Portfolio.new(portfolio)
    if @portfolio.save
      redirect resource(@portfolio), :message => {:notice => "Portfolio was successfully created"}
    else
      message[:error] = "Portfolio failed to be created"
      render :new
    end
  end

  def update(id, portfolio)
    @portfolio = Portfolio.get(id)
    raise NotFound unless @portfolio
    if @portfolio.update_attributes(portfolio)
       redirect resource(@portfolio)
    else
      display @portfolio, :edit
    end
  end

  def destroy(id)
    @portfolio = Portfolio.get(id)
    raise NotFound unless @portfolio
    if @portfolio.destroy
      redirect resource(:portfolios)
    else
      raise InternalServerError
    end
  rescue InternalServerError
    @_message = 'I`m sorry but something went wrong'
  ensure
    redirect_resource :portfolios,:error=> 'Somthing went wrond'
  end

end # Portfolios
