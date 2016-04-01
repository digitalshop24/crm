require "smsc_api.rb"
class WelcomeController < ApplicationController
  # load_and_authorize_resource :class => false
  layout 'welcome'
  autocomplete :subspeciality, :subspeciality
  def index
    @order = Order.new
    @client = Client.new
  end

  def tform
    Tform.create(name: params[:name], city: params[:city], email: params[:email])
    render nothing: true
  end

def fail
end

 def parse_date_ru date
    monthes = {
      "января" => "01",
      "февраля" => "02",
      "марта" => "03",
      "апреля" => "04",
      "мая" => "05",
      "июня" => "06",
      "июля" => "07",
      "августа" => "08",
      "сентября" => "09",
      "октября" => "10",
      "ноября" => "11",
      "декабря" => "12"
    }
    pattern = /[а-я]+/
    if date
      a = date.gsub(pattern, monthes[date[pattern]].to_s)
      Date.strptime(a, '%d %m %Y')
    end
  end

  def create_order
    @order = Order.new(order_params.except(:client))
    @order.subspeciality = Subspeciality.where(subspeciality: params[:subspeciality]).first
    @order.deadline = parse_date_ru(params[:order][:deadline])
    if current_user
      @order.client_id = current_user.id if current_user.role = "Client"
      if @order.save
        if params[:materials]
          params[:materials].each {|file| @order.materials.create(document: file)}
        end
        redirect_to root_path, notice: 'Заказ успешно создан.'
      else
        flash[:notice] = 'Ошибка'
        redirect_to root_path
      end
    else
      @client = Client.new(order_params[:client].merge({ activated: true }))
      @client.password = SecureRandom.hex
      if @client.save
        @order.client_id = @client.id
        #sms = SMSC.new()
        #tut ret = sms.send_sms( @client.phone, "Вы успешно зарегистрированы на сайте редстудент, вам на электронную почту придут дальнейшие инструкции")
        #tut email = URI.encode("https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@client.email}&mes=#{message}&sender=Avtor@redstudent.ru&subj=Registration&mail=1")
          #sms = URI.encode("https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@client.phone}&mes=Ваш Редстудент")
          #email = URI.encode("https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@client.email}&mes=test&sender=3206297@mail.ru&subj=test&mail=1")
        # tut uri = URI(email)
          #url = URI(sms)
        #tut a = Net::HTTP.get(uri)
          #a = Net::HTTP.get(url)
       #UserMailer.delay.set_password_instructions(@client, token)
        if @order.save  
          if params[:materials]
            params[:materials].each {|file| @order.materials.create(document: file)}
          end
          sign_in(:user, @client)
          redirect_to dashboard_index_path, notice: 'Заказ создан. Вы получите на email инструкцию для задания пароля'
        else
          redirect_to root_path, notice: 'Ошибка'
        end
      else
        redirect_to root_path, notice: 'Такой email уже зарегистрирован в системе. Восстановить пароль <a href="/users/password/new">тут</a>'
      end
    end
  end

  private
  def order_params
    params.require(:order).permit(:subspeciality_id, :worktype_id, :worktype_other, :speciality_id, :speciality_other,
                                  :institution, :theme, :uniqueness, :document, :comment, :deadline,
                                  :page_number, { client: [:email, :phone] })
  end
end
